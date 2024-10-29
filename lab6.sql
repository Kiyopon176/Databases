
-- 2. Create tables
CREATE TABLE locations(
    location_id SERIAL PRIMARY KEY,
    street_address VARCHAR(25),
    postal_code VARCHAR(12),
    city VARCHAR(30),
    state_province VARCHAR(12)
);

CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) UNIQUE,
    budget INTEGER,
    location_id INTEGER REFERENCES locations
);

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    phone_number VARCHAR(20),
    salary INTEGER,
    department_id INTEGER REFERENCES departments
);

-- 3. Select first name, last name, department id, and department name for each employee
SELECT employees.first_name, employees.last_name, employees.department_id, departments.department_name
FROM employees
JOIN departments ON employees.department_id = departments.department_id;

-- 4. Select first name, last name, department id, and department name for departments 80 or 40
SELECT e.first_name, e.last_name, e.department_id, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_id IN (80, 40);

-- 5. Select first name, last name, department, city, and state province for each employee
SELECT e.first_name, e.last_name, d.department_name, l.city, l.state_province
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id;

-- 6. Select all departments including those with no employees
SELECT d.department_id, d.department_name, e.employee_id
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id;

-- 7. Select first name, last name, department id, and name for all employees with or without a department
SELECT e.first_name, e.last_name, d.department_id, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;
