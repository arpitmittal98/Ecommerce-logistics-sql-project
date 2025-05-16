
# 📄 Data Description

## 📦 Customers  
Stores the information of all users registered on the e-commerce platform.  
**Attributes:**
- `CustomerID` *(SERIAL, Primary Key)* – Unique ID for each customer.  
- `Name` *(VARCHAR)* – Full name of the customer.  
- `Email` *(VARCHAR)* – Unique email used for identification and communication.  
- `PhoneNumber` *(VARCHAR)* – Customer's phone number for support/marketing.  
- `Address` *(TEXT)* – Shipping and billing address.  
- `SignupDate` *(DATE)* – Date of account creation.  
**Foreign Key Actions:** None

## 🛍️ Products  
Stores product catalog details.  
**Attributes:**
- `ProductID` *(SERIAL, Primary Key)* – Unique ID for each product.  
- `ProductName` *(VARCHAR)* – Name of the product.  
- `ProductDescription` *(VARCHAR)* – Detailed description.  
- `Price` *(DECIMAL)* – Selling price.  
- `StockLevel` *(INTEGER)* – Available inventory.  
- `CategoryName` *(VARCHAR)* – Product category (e.g., Electronics).  
- `VendorID` *(INTEGER)* – Foreign key to `Vendors(VendorID)`.  
**Foreign Key Actions:** `VendorID → ON DELETE SET NULL`

## 📦 Orders  
Details of customer orders.  
**Attributes:**
- `OrderID` *(SERIAL, Primary Key)* – Unique order identifier.  
- `CustomerID` *(INTEGER)* – Foreign key to `Customers(CustomerID)`.  
- `OrderDate` *(DATE)* – Date the order was placed.  
- `TotalAmount` *(DECIMAL)* – Total cost.  
- `PaymentMethod` *(VARCHAR)* – Mode of payment.  
- `OrderStatus` *(VARCHAR)* – Current status (e.g., Pending, Shipped).  
**Foreign Key Actions:** `CustomerID → ON DELETE CASCADE`

## 🚚 Shipments  
Tracks shipments for orders.  
**Attributes:**
- `ShipmentID` *(SERIAL, Primary Key)* – Unique shipment ID.  
- `OrderID` *(INTEGER)* – Foreign key to `Orders(OrderID)`.  
- `ShipmentDate` *(DATE)* – Dispatch date.  
- `EstimatedDeliveryDate` *(DATE)* – Expected arrival date.  
- `ActualDeliveryDate` *(DATE, nullable)* – Real arrival date.  
- `Carrier` *(VARCHAR)* – Shipping provider.  
- `TrackingNumber` *(VARCHAR)* – Tracking reference.  
**Foreign Key Actions:** `OrderID → ON DELETE CASCADE`

## 🏭 Vendors  
Information about product suppliers.  
**Attributes:**
- `VendorID` *(SERIAL, Primary Key)* – Unique ID for each vendor.  
- `VendorName` *(VARCHAR)* – Vendor name.  
- `ContactPerson` *(VARCHAR)* – Point of contact.  
- `PhoneNumber` *(VARCHAR)* – Contact number.  
- `Email` *(VARCHAR)* – Contact email.  
- `Address` *(TEXT)* – Vendor’s location.  
**Foreign Key Actions:** None

## 🔁 Returns  
Tracks product returns by customers.  
**Attributes:**
- `ReturnID` *(SERIAL, Primary Key)* – Unique return request ID.  
- `OrderID` *(INTEGER)* – Foreign key to `Orders(OrderID)`.  
- `ProductID` *(INTEGER)* – Foreign key to `Products(ProductID)`.  
- `ReturnDate` *(DATE)* – Date return was initiated.  
- `ReturnReason` *(VARCHAR)* – Customer's reason.  
- `RefundAmount` *(DECIMAL)* – Amount refunded.  
**Foreign Key Actions:**  
- `OrderID → ON DELETE CASCADE`  
- `ProductID → ON DELETE CASCADE`

## ⭐ Reviews  
Stores feedback submitted by customers.  
**Attributes:**
- `ReviewID` *(SERIAL, Primary Key)* – Unique ID for each review.  
- `CustomerID` *(INTEGER)* – Foreign key to `Customers(CustomerID)`.  
- `ProductID` *(INTEGER)* – Foreign key to `Products(ProductID)`.  
- `Rating` *(INTEGER)* – Star rating (1–5).  
- `ReviewText` *(TEXT, nullable)* – Optional written comment.  
- `ReviewDate` *(DATE)* – Date of submission.  
**Foreign Key Actions:**  
- `CustomerID → ON DELETE CASCADE`  
- `ProductID → ON DELETE CASCADE`

## 🏬 Inventory  
Tracks stock levels in warehouses.  
**Attributes:**
- `InventoryID` *(SERIAL, Primary Key)* – Unique record ID.  
- `ProductID` *(INTEGER)* – Foreign key to `Products(ProductID)`.  
- `WarehouseID` *(INTEGER)* – Foreign key to `Warehouses(WarehouseID)`.  
- `StockLevel` *(INTEGER)* – Units in stock.  
- `LastUpdated` *(DATE)* – Last restocked date.  
**Foreign Key Actions:**  
- `ProductID → ON DELETE CASCADE`  
- `WarehouseID → ON DELETE CASCADE`

## 🧾 Order Items  
Details of individual items in orders.  
**Attributes:**
- `OrderItemID` *(SERIAL, Primary Key)* – Unique line item ID.  
- `OrderID` *(INTEGER)* – Foreign key to `Orders(OrderID)`.  
- `ProductID` *(INTEGER)* – Foreign key to `Products(ProductID)`.  
- `Quantity` *(INTEGER)* – Units purchased.  
- `PriceAtPurchase` *(DECIMAL)* – Unit price at order time.  
**Foreign Key Actions:**  
- `OrderID → ON DELETE CASCADE`  
- `ProductID → ON DELETE CASCADE`

## 🏢 Warehouses  
Information about storage facilities.  
**Attributes:**
- `WarehouseID` *(SERIAL, Primary Key)* – Unique ID.  
- `WarehouseName` *(VARCHAR)* – Warehouse label/code.  
- `Location` *(VARCHAR)* – Address or region.  
- `Capacity` *(INTEGER)* – Storage limit.  
**Foreign Key Actions:** None
