CREATE OR REPLACE FUNCTION update_product_price(
    p_product_id INTEGER,
    p_new_price DECIMAL
)
RETURNS VOID AS $$
BEGIN
    UPDATE Products
    SET Price = p_new_price
    WHERE ProductID = p_product_id;
END;
$$ LANGUAGE plpgsql;


SELECT update_product_price(14, 299.99);

SELECT ProductID, ProductName, Price
FROM Products
WHERE ProductID = 14;
