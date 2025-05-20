CREATE OR REPLACE FUNCTION prevent_negative_stock()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.StockLevel < 0 THEN
        RAISE EXCEPTION 'Stock cannot be negative!';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_stock_before_update
BEFORE UPDATE ON Products
FOR EACH ROW
EXECUTE FUNCTION prevent_negative_stock();

BEGIN;

-- Simulate an order being placed
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount, PaymentMethod, OrderStatus)
VALUES (1, CURRENT_DATE, 500.00, 'Credit Card', 'Pending');

-- Try to update product stock — deliberately cause stock to go negative
UPDATE Products
SET StockLevel = StockLevel - 20
WHERE ProductID = 7;

COMMIT;

