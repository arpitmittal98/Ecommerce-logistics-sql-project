DROP TABLE inventory, order_items, orders, products, returns, reviews, shipments, vendors, warehouses, customers;

-- Customers Table
CREATE TABLE Customers (
    CustomerID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
	Email VARCHAR(255) NOT NULL UNIQUE,  -- Ensure unique emails
    PhoneNumber VARCHAR(50) UNIQUE,  
    Address TEXT,
    SignupDate DATE NOT NULL
);

-- Vendors Table
CREATE TABLE Vendors (
    VendorID SERIAL PRIMARY KEY,
    VendorName VARCHAR(255) NOT NULL,
    ContactPerson VARCHAR(255),
    PhoneNumber VARCHAR(50) UNIQUE,  
    Email VARCHAR(255) UNIQUE,   
    Address TEXT
);


-- Products Table
CREATE TABLE Products (
    ProductID SERIAL PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    ProductDescription TEXT,
    Price DECIMAL(10, 2) NOT NULL,
    StockLevel INTEGER NOT NULL,
    CategoryName VARCHAR(100) NOT NULL,
    VendorID INTEGER REFERENCES Vendors(VendorID)
);


-- Orders Table
CREATE TABLE Orders (
    OrderID SERIAL PRIMARY KEY,
    CustomerID INTEGER NOT NULL REFERENCES Customers(CustomerID),
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    PaymentMethod VARCHAR(50) CHECK (PaymentMethod IN ('Credit Card', 'PayPal', 'Bank Transfer', 'Cash on Delivery')),
    OrderStatus VARCHAR(50) CHECK (OrderStatus IN ('Pending', 'Shipped', 'Delivered', 'Canceled', 'Returned'))
);


-- Order_Items Table
CREATE TABLE Order_Items (
    OrderItemID SERIAL PRIMARY KEY,
    OrderID INTEGER NOT NULL REFERENCES Orders(OrderID),
    ProductID INTEGER NOT NULL REFERENCES Products(ProductID),
    Quantity INTEGER NOT NULL,
    PriceAtPurchase DECIMAL(10, 2) NOT NULL
);



-- Shipments Table
CREATE TABLE Shipments (
    ShipmentID SERIAL PRIMARY KEY,
    OrderID INTEGER NOT NULL REFERENCES Orders(OrderID),
    ShipmentDate DATE NOT NULL,
    EstimatedDeliveryDate DATE NOT NULL,
    ActualDeliveryDate DATE,
    Carrier VARCHAR(50) CHECK (Carrier IN ('FedEx', 'UPS', 'DHL', 'USPS', 'Local Courier')),
    TrackingNumber VARCHAR(255)
);


-- Returns Table
CREATE TABLE Returns (
    ReturnID SERIAL PRIMARY KEY,
    OrderID INTEGER NOT NULL REFERENCES Orders(OrderID),
    ProductID INTEGER NOT NULL REFERENCES Products(ProductID),
    ReturnDate DATE NOT NULL,
    ReturnReason VARCHAR(50) CHECK (ReturnReason IN ('Damaged', 'Wrong Item', 'Not as Described', 'Other')),
    RefundAmount DECIMAL(10, 2) NOT NULL
);


-- Review Table
CREATE TABLE Reviews (
    ReviewID SERIAL PRIMARY KEY,
    CustomerID INTEGER NOT NULL REFERENCES Customers(CustomerID),
    ProductID INTEGER NOT NULL REFERENCES Products(ProductID),
    Rating INTEGER CHECK (Rating BETWEEN 1 AND 5),
    ReviewText TEXT,
    ReviewDate DATE NOT NULL
);


-- Warehouses Table
CREATE TABLE Warehouses (
    WarehouseID SERIAL PRIMARY KEY,
    WarehouseName VARCHAR(255) NOT NULL,
    Location VARCHAR(255) NOT NULL,
    Capacity INTEGER NOT NULL
);


-- Inventory Table
CREATE TABLE Inventory (
    InventoryID SERIAL PRIMARY KEY,
    ProductID INTEGER NOT NULL REFERENCES Products(ProductID),
    WarehouseID INTEGER NOT NULL REFERENCES Warehouses(WarehouseID),
    StockLevel INTEGER NOT NULL,
    LastUpdated DATE NOT NULL
);

SELECT * FROM customers;