/*
===============================================================
Reporting View: vw_order_summary
===============================================================
Script Purpose:
    Creates a unified reporting view combining order, customer,
    product, and delivery data for business analysis. This view
    serves as a single source of truth for dashboards and 
    ad-hoc queries.

    Usage: SELECT * FROM vw_order_summary;
===============================================================
*/

CREATE VIEW vw_order_summary AS
SELECT ot.order_id,
       c.customer_unique_id,
       ot.price,
       ot.freight_value,
       c.customer_city,
       ord.order_purchase_timestamp,
       ord.order_status,
       od.order_delivered_customer_date,
       od.order_estimated_delivery_date,
       ct.product_category_name_english
FROM orders ord 
LEFT JOIN order_items ot ON ord.order_id=ot.order_id
LEFT JOIN products p ON ot.product_id=p.product_id
LEFT JOIN customers c ON ord.customer_id=c.customer_id
LEFT JOIN orders_delivered od ON ord.order_id=od.order_id
LEFT JOIN category_translation ct ON ct.product_category_name=p.product_category_name;
