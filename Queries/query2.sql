INSERT INTO Products (ProductName, ProductDescription, Price, StockLevel, CategoryName, VendorID)
VALUES ('SONY XM4', 'High-quality noise cancelling headphones', 199.99, 500, 'Electronics', 5);

SELECT *
FROM Products
WHERE ProductName = 'SONY XM4' and VendorID = '5';