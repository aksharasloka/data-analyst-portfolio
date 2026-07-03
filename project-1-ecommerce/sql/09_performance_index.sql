/*
===============================================================
Performance Indexes: Olist E-Commerce Database
===============================================================
Script Purpose:
    Creates indexes on frequently queried columns to optimize
    query performance for date range filters, category joins,
    and customer-level analysis.
===============================================================
*/

CREATE INDEX idx_orders_purchase_timestamp 
ON orders(order_purchase_timestamp);

CREATE INDEX idx_product_category_name 
ON category_translation(product_category_name);

CREATE INDEX idx_customer_unique_id ON 
customers(customer_unique_id);

