import faker
import random
import psycopg2
from datetime import datetime, timedelta

# Initialize Faker
fake = faker.Faker()

# Database connection
db = psycopg2.connect(
    host="localhost",
    user="postgres",  # Replace with your username
    password="",  # Replace with your password
    database="Problem 2"
)
cursor = db.cursor()

# Constants
NUM_ROWS = 3100  # Number of rows to generate for each table

# Helper functions
def generate_date(start_year=2020, end_year=2023):
    start = datetime(start_year, 1, 1)
    end = datetime(end_year, 12, 31)
    return fake.date_between(start_date=start, end_date=end)

# Generate Customers
print("Generating Customers...")
customers = []
generated_emails = set()  # Track generated emails to ensure uniqueness
generated_phone_numbers = set()
for _ in range(NUM_ROWS):
    while True:
        email = fake.email()
        if email not in generated_emails:
            generated_emails.add(email)
            break
    while True:
        phone_number = fake.phone_number()[:15]
        if phone_number not in generated_phone_numbers:
            generated_phone_numbers.add(phone_number)
            break
    cursor.execute(
        "INSERT INTO Customers (Name, Email, PhoneNumber, Address, SignupDate) VALUES (%s, %s, %s, %s, %s) RETURNING CustomerID",
        (fake.name(), email, phone_number, fake.address(), generate_date())
    )
    customer_id = cursor.fetchone()[0]  # Retrieve the last inserted CustomerID
    customers.append(customer_id)
db.commit()

# Generate Vendors
print("Generating Vendors...")
generated_vendor_emails = set()
generated_vendor_phone_numbers = set()
vendors = []
for _ in range(NUM_ROWS):
    while True:
        email = fake.email()
        if email not in generated_vendor_emails:
            generated_vendor_emails.add(email)
            break
    while True:
        phone_number = fake.phone_number()[:15]
        if phone_number not in generated_vendor_phone_numbers:
            generated_vendor_phone_numbers.add(phone_number)
            break
    cursor.execute(
        "INSERT INTO Vendors (VendorName, ContactPerson, PhoneNumber, Email, Address) VALUES (%s, %s, %s, %s, %s) RETURNING VendorID",
        (fake.company(), fake.name(), phone_number, email, fake.address())
    )
    vendor_id = cursor.fetchone()[0]  # Retrieve the last inserted VendorID
    vendors.append(vendor_id)
db.commit()

# Generate Products
print("Generating Products...")
products = []
categories = ["Electronics", "Clothing", "Home & Kitchen", "Books", "Toys", "Accessories"]
for _ in range(NUM_ROWS):
    if vendors:  # Ensure there are vendors to reference
        vendor_id = random.choice(vendors)  # Randomly select a valid VendorID
        cursor.execute(
            "INSERT INTO Products (ProductName, ProductDescription, Price, StockLevel, CategoryName, VendorID) VALUES (%s, %s, %s, %s, %s, %s) RETURNING ProductID",
            (fake.word(), fake.text(), round(random.uniform(10, 1000), 2), random.randint(1, 1000), random.choice(categories), vendor_id)
        )
        product_id = cursor.fetchone()[0]  # Retrieve the last inserted ProductID
        products.append(product_id)
db.commit()

# Generate Orders
print("Generating Orders...")
orders = []
for _ in range(NUM_ROWS):
    customer_id = random.choice(customers)  # Randomly select a customer
    cursor.execute(
        "INSERT INTO Orders (CustomerID, OrderDate, TotalAmount, PaymentMethod, OrderStatus) VALUES (%s, %s, %s, %s, %s) RETURNING OrderID",
        (customer_id, generate_date(), round(random.uniform(50, 1000), 2), random.choice(['Credit Card', 'PayPal', 'Bank Transfer', 'Cash on Delivery']), random.choice(['Pending', 'Shipped', 'Delivered', 'Canceled', 'Returned']))
    )
    order_id = cursor.fetchone()[0]  # Retrieve the last inserted OrderID
    orders.append(order_id)
db.commit()

# Generate Order_Items
print("Generating Order_Items...")
order_items = []
for _ in range(NUM_ROWS):
    order_id = random.choice(orders)  # Randomly select an order
    product_id = random.choice(products)  # Randomly select a product
    cursor.execute(
        "INSERT INTO Order_Items (OrderID, ProductID, Quantity, PriceAtPurchase) VALUES (%s, %s, %s, %s) RETURNING OrderItemID",
        (order_id, product_id, random.randint(1, 10), round(random.uniform(10, 1000), 2))
    )
    order_item_id = cursor.fetchone()[0]  # Retrieve the last inserted OrderItemID
    order_items.append((order_id, product_id))  # Store valid order-item pairs
db.commit()

# Generate Shipments
print("Generating Shipments...")
for _ in range(NUM_ROWS):
    order_id = random.choice(orders)  # Randomly select an order
    cursor.execute(
        "INSERT INTO Shipments (OrderID, ShipmentDate, EstimatedDeliveryDate, ActualDeliveryDate, Carrier, TrackingNumber) VALUES (%s, %s, %s, %s, %s, %s) RETURNING ShipmentID",
        (order_id, generate_date(), generate_date(), generate_date() if random.choice([True, False]) else None, random.choice(['FedEx', 'UPS', 'DHL', 'USPS', 'Local Courier']), fake.uuid4() if random.choice([True, False]) else None)
    )
    shipment_id = cursor.fetchone()[0]  # Retrieve the last inserted ShipmentID
db.commit()

# Generate Returns
print("Generating Returns...")
for _ in range(NUM_ROWS):
    order_id, product_id = random.choice(order_items)  # Randomly select a valid order-item pair
    cursor.execute(
        "INSERT INTO Returns (OrderID, ProductID, ReturnDate, ReturnReason, RefundAmount) VALUES (%s, %s, %s, %s, %s) RETURNING ReturnID",
        (order_id, product_id, generate_date(), random.choice(['Damaged', 'Wrong Item', 'Not as Described', 'Other']), round(random.uniform(10, 1000), 2))
    )
    return_id = cursor.fetchone()[0]  # Retrieve the last inserted ReturnID
db.commit()

# Generate Reviews
print("Generating Reviews...")
for _ in range(NUM_ROWS):
    customer_id = random.choice(customers)  # Randomly select a customer
    product_id = random.choice(products)  # Randomly select a product
    cursor.execute(
        "INSERT INTO Reviews (CustomerID, ProductID, Rating, ReviewText, ReviewDate) VALUES (%s, %s, %s, %s, %s) RETURNING ReviewID",
        (customer_id, product_id, random.randint(1, 5), fake.text() if random.choice([True, False]) else None, generate_date())
    )
    review_id = cursor.fetchone()[0]  # Retrieve the last inserted ReviewID
db.commit()

# Generate Warehouses
print("Generating Warehouses...")
warehouses = []
for _ in range(NUM_ROWS):
    cursor.execute(
        "INSERT INTO Warehouses (WarehouseName, Location, Capacity) VALUES (%s, %s, %s) RETURNING WarehouseID",
        (fake.word(), fake.city(), random.randint(1000, 10000))
    )
    warehouse_id = cursor.fetchone()[0]  # Retrieve the last inserted WarehouseID
    warehouses.append(warehouse_id)
db.commit()

# Generate Inventory
print("Generating Inventory...")
for _ in range(NUM_ROWS):
    product_id = random.choice(products)  # Randomly select a product
    warehouse_id = random.choice(warehouses)  # Randomly select a warehouse
    cursor.execute(
        "INSERT INTO Inventory (ProductID, WarehouseID, StockLevel, LastUpdated) VALUES (%s, %s, %s, %s) RETURNING InventoryID",
        (product_id, warehouse_id, random.randint(1, 1000), generate_date())
    )
    inventory_id = cursor.fetchone()[0]  # Retrieve the last inserted InventoryID
db.commit()

# Close connection
cursor.close()
db.close()
print("Data generation complete!")