SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'adventure_works'
  AND pid <> pg_backend_pid();

DROP DATABASE adventure_works;

CREATE DATABASE adventure_works;

CREATE TABLE customers (customer_id SERIAL PRIMARY KEY, customer_name VARCHAR(255) NOT NULL, customer_phone_num VARCHAR(50) NOT NULL, customer_email VARCHAR(255) NOT NULL);

CREATE TABLE order_statuses (status_id SERIAL PRIMARY KEY, status VARCHAR(255) NOT NULL);

CREATE TABLE suppliers (supplier_id SERIAL PRIMARY KEY, supplier VARCHAR(255) NOT NULL, supplier_email VARCHAR(255) NOT NULL, supplier_phone VARCHAR(255) NULL);

CREATE TABLE categories (category_id SERIAL PRIMARY KEY, category VARCHAR(255) NOT NULL);

CREATE TABLE orders (order_id SERIAL PRIMARY KEY, customer_id INT NOT NULL, order_date DATE NOT NULL, status_id INT NOT NULL, order_total FLOAT NOT NULL, CONSTRAINT fk_customer1 FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE, CONSTRAINT fk_status FOREIGN KEY (status_id) REFERENCES order_statuses(status_id) ON DELETE CASCADE);

CREATE TABLE products (product_id SERIAL PRIMARY KEY, product_name VARCHAR(255) NOT NULL, category_id INT NOT NULL, current_price FLOAT NOT NULL, product_description TEXT NULL, supplier_id INT NOT NULL, CONSTRAINT fk_supplier FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id) ON DELETE CASCADE, CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE);

CREATE TABLE product_prices (price_id SERIAL PRIMARY KEY, price FLOAT NOT NULL, price_date DATE NOT NULL, product_id INT NOT NULL, CONSTRAINT fk_product1 FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE);

CREATE TABLE reviews (review_id SERIAL PRIMARY KEY, customer_id INT NOT NULL, product_id INT NOT NULL, review TEXT NULL, rate INT NOT NULL, CONSTRAINT fk_customer2 FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE, CONSTRAINT fk_product2 FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE);

CREATE TABLE order_lines (orderline_id SERIAL PRIMARY KEY, order_id INT NOT NULL, product_id INT NOT NULL, quantity INT NOT NULL, orderline_total FLOAT NOT NULL, CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE, CONSTRAINT fk_product3 FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE);

