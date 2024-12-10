
-- Task 1: Transaction for Placing an Order

BEGIN TRANSACTION;

-- Insert an order into the Orders table
INSERT INTO Orders (order_id, book_id, customer_id, order_date, quantity)
VALUES (1, 1, 101, CURRENT_DATE, 2);

-- Update the Books table
UPDATE Books
SET quantity = quantity - 2
WHERE book_id = 1;

COMMIT;

-- Task 2: Transaction with Rollback

BEGIN TRANSACTION;

-- Attempt to insert an order
INSERT INTO Orders (order_id, book_id, customer_id, order_date, quantity)
VALUES (2, 3, 102, CURRENT_DATE, 10);

-- Check if sufficient quantity exists and rollback if not
IF (SELECT quantity FROM Books WHERE book_id = 3) < 10 THEN
    ROLLBACK;
ELSE
    -- Update the Books table
    UPDATE Books
    SET quantity = quantity - 10
    WHERE book_id = 3;
    COMMIT;
END IF;

-- Task 3: Isolation Level Demonstration

-- Session 1: Start a transaction and update the price
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

BEGIN TRANSACTION;
UPDATE Books
SET price = price + 5.00
WHERE book_id = 1;

-- Session 2: Start a transaction and read the price
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

BEGIN TRANSACTION;
SELECT price FROM Books WHERE book_id = 1;

-- Session 1: Commit the transaction
COMMIT;

-- Session 2: Re-read the price after commit
SELECT price FROM Books WHERE book_id = 1;

-- Task 4: Durability Check

BEGIN TRANSACTION;

-- Update a customer's email
UPDATE Customers
SET email = 'newemail@example.com'
WHERE customer_id = 101;

COMMIT;

-- After database restart, check the Customers table
SELECT * FROM Customers WHERE customer_id = 101;
