INSERT INTO Customers (Name, Email, PhoneNumber, Address, SignupDate)
VALUES ('Arpit Mittal', 'arpit.mittal@gmail.com', '+1-716-555-0199', '1234 Sunset Blvd, Buffalo, NY', CURRENT_DATE);


SELECT *
FROM Customers
WHERE Email = 'arpit.mittal@gmail.com';