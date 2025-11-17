INSERT INTO order_statuses (status)
VALUES ('Pending'), ('Processing'), ('Shipped'), ('Delivered'), ('Cancelled');

INSERT INTO categories (category)
VALUES ('Electronics'), ('Clothing'), ('Books'), ('Home'), ('Beauty'),
       ('Sports'), ('Toys'), ('Tools');

INSERT INTO suppliers (supplier, supplier_email, supplier_phone)
SELECT
    'Supplier ' || g,
    'supplier' || g || '@example.com',
    '+1-555-000' || g
FROM generate_series(1,10) g;

INSERT INTO customers (customer_name, customer_phone_num, customer_email)
SELECT
    'Customer ' || g,
    '+1-555-1234-' || LPAD(g::text, 4, '0'),
    'customer' || g || '@example.com'
FROM generate_series(1,40) g;

INSERT INTO products (product_name, category_id, current_price, product_description, supplier_id)
SELECT
    'Product ' || g AS product_name,
    (random() * 7 + 1)::int AS category_id,         
    (random() * 200 + 5)::numeric(10,2) AS price,   
    'Description for product ' || g AS description,
    (random() * 9 + 1)::int AS supplier_id          
FROM generate_series(1,75) g;

INSERT INTO product_prices (price, price_date, product_id)
SELECT
    (random() * 200 + 10)::numeric(10,2),
    NOW()::date - (random() * 400)::int,
    p.product_id
FROM products p, generate_series(1,3);

INSERT INTO orders (customer_id, order_date, status_id, order_total)
SELECT
    (random() * 39 + 1)::int,      
    NOW()::date - (random() * 365)::int,
    (random() * 4 + 1)::int,       
    0                              
FROM generate_series(1,180);


INSERT INTO order_lines (order_id, product_id, quantity, orderline_total)
SELECT
    o.order_id,
    (random() * 74 + 1)::int,              
    (random() * 4 + 1)::int AS qty,        
    0                                      
FROM orders o,
     generate_series(1,(random() * 3 + 2)::int);


UPDATE order_lines ol
SET orderline_total = (
    SELECT ol.quantity * pp.price
    FROM product_prices pp
    WHERE pp.product_id = ol.product_id
    ORDER BY price_date DESC LIMIT 1
);

UPDATE orders o
SET order_total = (
    SELECT SUM(orderline_total)
    FROM order_lines
    WHERE order_id = o.order_id
);

/*=== Exercise 3 ===*/

INSERT INTO reviews (customer_id, product_id, review, rate)
SELECT
    (random() * 39 + 1)::int,
    (random() * 74 + 1)::int,
    'Review for product ',
    (random() * 4 + 1)::int
FROM generate_series(1,100);

INSERT INTO loyalty (customer_id, loyalty_level, start_date, end_date, discount)
SELECT
    customer_id,
    CASE
        WHEN total_spent >= 500 THEN 'Gold'
        WHEN total_spent >= 200 THEN 'Silver'
        WHEN total_spent >= 50  THEN 'Bronze'
        ELSE 'None'
    END AS loyalty_level,
    date_trunc('month', CURRENT_DATE) - INTERVAL '1 month' AS start_date,
    date_trunc('month', CURRENT_DATE) - INTERVAL '1 day'   AS end_date,

    CASE
        WHEN total_spent >= 500 THEN 8
        WHEN total_spent >= 200 THEN 5
        WHEN total_spent >= 50  THEN 3
        ELSE 0
    END AS discount_percent

FROM (
    SELECT
        c.customer_id,
        COALESCE(SUM(o.order_total), 0) AS total_spent
    FROM customers c
    LEFT JOIN orders o
        ON o.customer_id = c.customer_id
       AND o.order_date BETWEEN
            (date_trunc('month', CURRENT_DATE) - INTERVAL '1 month')
            AND
            (date_trunc('month', CURRENT_DATE) - INTERVAL '1 day')
    GROUP BY c.customer_id
) monthly_totals
WHERE total_spent >= 50;
