-- Create the database and use it
CREATE DATABASE IF NOT EXISTS finapp;
USE finapp;

-- Create the customers table
CREATE TABLE IF NOT EXISTS customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

-- Create the products table
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- Create the orders table
CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

-- Create the order_details table
CREATE TABLE IF NOT EXISTS order_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Create the shopping_cart table
CREATE TABLE IF NOT EXISTS shopping_cart (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

-- Create the shopping_cart_items table
CREATE TABLE IF NOT EXISTS shopping_cart_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cart_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (cart_id) REFERENCES shopping_cart(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Insert sample data into the customers table
INSERT INTO customers (name, email) VALUES
('John Doe', 'john@example.com'),
('Jane Smith', 'jane@example.com');

-- Insert sample data into the products table
INSERT INTO products (product_name, price) VALUES
('Product 1', 9.99),
('Product 2', 19.99),
('Product 3', 29.99);

-- Insert sample data into the orders table
INSERT INTO orders (customer_id, total_amount) VALUES
(1, 49.98),
(2, 19.99);

-- Insert sample data into the order_details table
INSERT INTO order_details (order_id, product_id, quantity) VALUES
(1, 1, 2),
(2, 2, 1);

-- Insert sample data into the shopping_cart table
INSERT INTO shopping_cart (customer_id) VALUES
(1),
(2);

-- Insert sample data into the shopping_cart_items table
INSERT INTO shopping_cart_items (cart_id, product_id, quantity) VALUES
(1, 3, 1),
(2, 1, 1);
