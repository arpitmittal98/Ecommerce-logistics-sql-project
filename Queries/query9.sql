SELECT c.Name
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate IS NULL OR o.OrderDate < CURRENT_DATE - INTERVAL '60 months';
