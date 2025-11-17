CREATE OR REPLACE VIEW vw_fact_orderlines AS
SELECT
    ol.orderline_id,
    ol.order_id,
    ol.product_id,
    ol.quantity,
    ol.orderline_total,
    o.customer_id,
    o.order_date,
    o.status_id,
    os.status,
    o.order_total AS order_total_at_header,
    ol.orderline_total / NULLIF(ol.quantity, 0) AS unit_price
FROM order_lines ol
JOIN orders o
    ON ol.order_id = o.order_id
JOIN order_statuses os
    ON os.status_id = o.status_id;


CREATE OR REPLACE VIEW vw_dim_products_full AS
SELECT
    p.product_id,
    p.product_name,
    p.current_price,
    p.product_description,
    c.category_id,
    c.category AS category_name,
    s.supplier_id,
    s.supplier AS supplier_name,
    s.supplier_email,
    s.supplier_phone

FROM products p
JOIN categories c
    ON p.category_id = c.category_id
JOIN suppliers s
    ON p.supplier_id = s.supplier_id;

