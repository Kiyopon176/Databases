
-- Create the database structure for the Online Bookstore

-- Creating the Books table
CREATE TABLE IF NOT EXISTS Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL
);

-- Creating the Customers table
CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);

-- Creating the Orders table
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY,
    book_id INT,
    customer_id INT,
    order_date DATE NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Inserting sample data into the Books table
INSERT INTO Books (book_id, title, author, price, quantity)
SELECT 1, 'Database 101', 'A. Smith', 40.00, 10
WHERE NOT EXISTS (SELECT 1 FROM Books WHERE book_id = 1);

INSERT INTO Books (book_id, title, author, price, quantity)
SELECT 2, 'Learn SQL', 'B. Johnson', 35.00, 15
WHERE NOT EXISTS (SELECT 1 FROM Books WHERE book_id = 2);

INSERT INTO Books (book_id, title, author, price, quantity)
SELECT 3, 'Advanced DB', 'C. Lee', 50.00, 5
WHERE NOT EXISTS (SELECT 1 FROM Books WHERE book_id = 3);

-- Inserting sample data into the Customers table
INSERT INTO Customers (customer_id, name, email)
SELECT 101, 'John Doe', 'johndoe@example.com'
WHERE NOT EXISTS (SELECT 1 FROM Customers WHERE customer_id = 101);

INSERT INTO Customers (customer_id, name, email)
SELECT 102, 'Jane Doe', 'janedoe@example.com'
WHERE NOT EXISTS (SELECT 1 FROM Customers WHERE customer_id = 102);

-- Task 1: Transaction for Placing an Order
BEGIN TRANSACTION;

-- Insert an order into the Orders table
INSERT INTO Orders (order_id, book_id, customer_id, order_date, quantity)
SELECT 1, 1, 101, CURRENT_DATE, 2
WHERE NOT EXISTS (SELECT 1 FROM Orders WHERE order_id = 1);

-- Update the Books table
UPDATE Books
SET quantity = quantity - 2
WHERE book_id = 1;

COMMIT;

-- Task 2: Transaction with Rollback
BEGIN TRANSACTION;

-- Attempt to insert an order
INSERT INTO Orders (order_id, book_id, customer_id, order_date, quantity)
SELECT 2, 3, 102, CURRENT_DATE, 10
WHERE NOT EXISTS (SELECT 1 FROM Orders WHERE order_id = 2);

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
