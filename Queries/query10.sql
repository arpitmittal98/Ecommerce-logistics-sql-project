SELECT p.ProductName, v.VendorName
FROM Products p
JOIN Vendors v ON p.VendorID = v.VendorID;
