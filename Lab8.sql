
-- 2. Create tables "salesman", "customers", and "orders"
-- Создаем таблицу продавцов
CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    commission DECIMAL(5, 2)
);

-- Создаем таблицу клиентов
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    grade INT,
    salesman_id INT REFERENCES salesman(salesman_id)
);

-- Создаем таблицу заказов
CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10, 2),
    ord_date DATE,
    customer_id INT REFERENCES customers(customer_id),
    salesman_id INT REFERENCES salesman(salesman_id)
);


-- Вставляем данные в таблицу salesman
INSERT INTO salesman (salesman_id, name, city, commission) VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', 'Berlin', 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

-- Вставляем данные в таблицу customers
INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', 300, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);

-- Вставляем данные в таблицу orders
INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760.0, '2012-09-10', 3002, 5001);

-- 3. Создание роли 'junior_dev'
CREATE ROLE junior_dev LOGIN;

-- 4. Представление для продавцов из Нью-Йорка
CREATE VIEW new_york_salesmen AS
SELECT *
FROM salesman
WHERE city = 'New York';

-- 5. Представление для заказов с именами продавца и клиента
CREATE VIEW order_salesman_customer AS
SELECT o.ord_no, o.purch_amt, o.ord_date, s.name AS salesman_name, c.cust_name AS customer_name
FROM orders o
JOIN salesman s ON o.salesman_id = s.salesman_id
JOIN customers c ON o.customer_id = c.customer_id;

-- 6. Представление для клиентов с наивысшим рейтингом
CREATE VIEW highest_grade_customers AS
SELECT *
FROM customers
WHERE grade = (SELECT MAX(grade) FROM customers);

-- 7. Представление для количества продавцов в каждом городе
CREATE VIEW city_salesman_count AS
SELECT city, COUNT(*) AS salesman_count
FROM salesman
GROUP BY city;

-- 8. Представление для продавцов с более чем одним клиентом
CREATE VIEW salesman_multiple_customers AS
SELECT s.salesman_id, s.name
FROM salesman s
JOIN customers c ON s.salesman_id = c.salesman_id
GROUP BY s.salesman_id, s.name
HAVING COUNT(c.customer_id) > 1;

-- 9. Создание роли 'intern'
CREATE ROLE intern;

-- Предоставление всех привилегий 'junior_dev' роли 'intern'
GRANT junior_dev TO intern;