SELECT p.ProductName, w.WarehouseName, i.StockLevel
FROM Inventory i
JOIN Products p ON i.ProductID = p.ProductID
JOIN Warehouses w ON i.WarehouseID = w.WarehouseID
ORDER BY i.StockLevel DESC;
