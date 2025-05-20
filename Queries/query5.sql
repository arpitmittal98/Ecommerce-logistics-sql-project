SELECT CategoryName, SUM(TotalAmount) AS TotalRevenue
FROM Orders o
JOIN Order_Items oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
GROUP BY CategoryName;