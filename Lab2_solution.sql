
-- 1. Create database called «lab2»
CREATE DATABASE lab2;

CREATE TABLE countries (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(255),
    region_id INT,
    population INT
);

-- 3. Insert a row with any data into the table countries against each column.
INSERT INTO countries (country_name, region_id, population)
VALUES ('USA', 1, 331000000);

-- 4. Insert one row into the table countries against the column country_id and country_name.
INSERT INTO countries (country_id, country_name)
VALUES (2, 'Canada');

-- 5. Insert NULL value to region_id column for a row of countries table.
INSERT INTO countries (country_name, region_id, population)
VALUES ('Mexico', NULL, 126000000);

-- 6. Insert 3 rows by a single insert statement.
INSERT INTO countries (country_name, region_id, population) 
VALUES ('Brazil', 2, 212000000), ('Argentina', 2, 45000000), ('Chile', 2, 19000000);

-- 7. Set default value ‘Kazakhstan’ to country_name column.
ALTER TABLE countries ALTER country_name SET DEFAULT 'Kazakhstan';

-- 8. Insert default value to country_name column for a row of countries table.
INSERT INTO countries (country_name, region_id, population) 
VALUES (DEFAULT, 3, 19000000);

-- 9. Insert only default values against each column of countries table.
INSERT INTO countries (country_name, region_id, population) 
VALUES (DEFAULT, DEFAULT, DEFAULT);

-- 10. Create duplicate of countries table named countries_new with all structure using LIKE keyword.
CREATE TABLE countries_new LIKE countries;

-- 11. Insert all rows from countries table to countries_new table.
INSERT INTO countries_new SELECT * FROM countries;

-- 12. Change region_id of country to «1» if it equals NULL. (Use WHERE clause and IS NULL operator)
UPDATE countries SET region_id = 1 WHERE region_id IS NULL;

-- 13. Write a SQL statement to increase population of each country by 10%. Statement should return country_name and updated population column with name «New Population»(alias).
SELECT country_name, population * 1.10 AS "New Population" FROM countries;

-- 14. Remove all rows from countries table which has less than 100k population.
DELETE FROM countries WHERE population < 100000;

-- 15. Remove all rows from countries_new table if country_id exists in countries table. Statement should return all deleted data.
DELETE FROM countries_new WHERE country_id IN (SELECT country_id FROM countries) RETURNING *;

-- 16. Remove all rows from countries table. Statement should return all deleted data.
DELETE FROM countries RETURNING *;
