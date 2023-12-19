-- kill other connections
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'week1_workshop' AND pid <> pg_backend_pid();
-- (re)create the database
DROP DATABASE IF EXISTS week1_workshop;
CREATE DATABASE week1_workshop;
-- connect via psql
\c week1_workshop

-- database configuration
SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET default_tablespace = '';
SET default_with_oids = false;


---
--- CREATE tables
---

CREATE TABLE products (
    id SERIAL,
    name TEXT NOT NULL,
    discontinued BOOLEAN NOT NULL,
    supplier_id INT,
    category_id INT,
    PRIMARY KEY (id)
);


CREATE TABLE categories (
    id SERIAL,
    name TEXT UNIQUE NOT NULL,
    description TEXT,
    picture TEXT,
    PRIMARY KEY (id)
);

-- TODO create more tables here...
--CREATE TABLE for suppliers entity
CREATE TABLE suppliers(
id SERIAL PRIMARY KEY,
name TEXT NOT NULL
);

--CREATE TABLE for customers entity
CREATE TABLE customers (
id SERIAL PRIMARY KEY,
company_name TEXT NOT NULL
);

--CREATE TABLE for employees entity
CREATE TABLE employees (
id SERIAL PRIMARY KEY,
first_name TEXT NOT NULL,
last_name TEXT NOT NULL	
);

--CREATE TABLE for orders entity
CREATE TABLE orders (
id SERIAL PRIMARY KEY,
date DATE,
customer_id INT NOT NULL,
employee_id INT	
);

--CREATE TABLE for orders_products entity
CREATE TABLE orders_products(
product_id INT NOT NULL,
order_id INT NOT NULL,
quantity INT NOT NULL,
discount NUMERIC NOT NULL
);

--CREATE TABLE for territories entity
CREATE TABLE territories(
id SERIAL PRIMARY KEY,
description TEXT NOT NULL
);

--CREATE TABLE for employees_territories entity
CREATE TABLE  employees_territories(
employee_id INT NOT NULL ,
territory_id INT NOT NULL,
PRIMARY KEY (employee_id, territory_id)
);

--CREATE TABLE for offices entity
CREATE TABLE offices(
id SERIAL PRIMARY KEY,
address_line TEXT NOT NULL,
territory_id INT NOT NULL
);

--CREATE TABLE for us_states entity
CREATE TABLE us_states(
id SERIAL PRIMARY KEY,
name TEXT NOT NULL,   
abbreviation  CHARACTER(2) NOT NULL 
);



---
--- Add foreign key constraints
---

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers 
FOREIGN KEY (customer_id)
REFERENCES customers(id);



ALTER TABLE orders
ADD CONSTRAINT fk_orders_employees
FOREIGN KEY (employee_id)
REFERENCES employees(id);

-- PRODUCTS
-- TODO create more constraints here...

ALTER TABLE products
ADD CONSTRAINT fk_products_categories 
FOREIGN KEY (category_id) 
REFERENCES categories (id);


ALTER TABLE products
ADD CONSTRAINT fk_products_suppliers 
FOREIGN KEY (supplier_id) 
REFERENCES suppliers (id);

ALTER TABLE orders_products
ADD CONSTRAINT fk_orders_products_orders
FOREIGN KEY (order_id) 
REFERENCES orders (id);

ALTER TABLE orders_products
ADD CONSTRAINT fk_orders_products_products
FOREIGN KEY (product_id) 
REFERENCES products (id);

ALTER TABLE employees_territories
ADD CONSTRAINT fk_employees_territories_employees
FOREIGN KEY (employee_id) 
REFERENCES employees (id);

ALTER TABLE employees_territories
ADD CONSTRAINT fk_employees_territories_territories
FOREIGN KEY (territory_id) 
REFERENCES territories (id);


ALTER TABLE offices
ADD CONSTRAINT offices_territories
FOREIGN KEY (territory_id) 
REFERENCES territories (id);




