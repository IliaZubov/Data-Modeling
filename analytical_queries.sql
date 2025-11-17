/*=== Top 10 selling products ===*/
SELECT SUM(ol.quantity) AS quantity, p.product_name FROM order_lines ol INNER JOIN products p ON ol.product_id = p.product_id GROUP BY p.product_id ORDER BY quantity DESC LIMIT 10;

/*=== Top 10 most valuable customers ===*/
SELECT o.customer_id, c.customer_name, ROUND(SUM(o.order_total) :: NUMERIC, 2) AS total_spend FROM orders o INNER JOIN customers c ON o.customer_id = c.customer_id GROUP BY o.customer_id, c.customer_name ORDER BY total_spend DESC LIMIT 10;