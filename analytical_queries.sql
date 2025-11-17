/*=== Top 10 selling products ===*/
SELECT SUM(ol.quantity) AS quantity, p.product_name FROM order_lines ol INNER JOIN products p ON ol.product_id = p.product_id GROUP BY p.product_id ORDER BY quantity DESC LIMIT 10;

/*=== Top 10 most valuable customers ===*/
SELECT o.customer_id, c.customer_name, ROUND(SUM(o.order_total) :: NUMERIC, 2) AS total_spend FROM orders o INNER JOIN customers c ON o.customer_id = c.customer_id GROUP BY o.customer_id, c.customer_name ORDER BY total_spend DESC LIMIT 10;

SELECT SUM(ol.quantity) AS quantity, p.product_name, COUNT(r.product_id) AS most_reviewed FROM order_lines ol INNER JOIN products p ON ol.product_id = p.product_id INNER JOIN reviews r ON r.product_id = p.product_id GROUP BY p.product_name, r.product_id, r.product_id ORDER BY most_reviewed DESC, quantity DESC LIMIT 10;

CREATE INDEX idx_product ON products(product_id);

SELECT 
    p.product_id, 
    p.product_name, 
    COALESCE(r.number_of_reviews, 0) AS number_of_reviews, 
    COALESCE(ol.quantity,0) AS quantity 
    FROM products p 
        LEFT JOIN (SELECT product_id, COUNT(*) AS number_of_reviews FROM reviews GROUP BY product_id) r ON r.product_id = p.product_id 
        LEFT JOIN (SELECT product_id, SUM(quantity) AS quantity FROM order_lines group by product_id) ol ON ol.product_id = p.product_id 
        ORDER BY quantity DESC, number_of_reviews DESC;