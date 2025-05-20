CREATE OR REPLACE FUNCTION insert_customer(
    p_name VARCHAR,
    p_email VARCHAR,
    p_phone VARCHAR,
    p_address TEXT
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO Customers (Name, Email, PhoneNumber, Address, SignupDate)
    VALUES (p_name, p_email, p_phone, p_address, CURRENT_DATE);
END;
$$ LANGUAGE plpgsql;

SELECT insert_customer('Jayanth', 'jayanth.20@outlook.com', '+1-716-757-0135', '456 Elm Street, Springfield');

SELECT * 
FROM Customers 
WHERE Email = 'jayanth.20@outlook.com';