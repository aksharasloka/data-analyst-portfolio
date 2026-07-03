/*
===============================================================
Function: get_revenue_summary
===============================================================
Script Purpose:
    Returns a revenue summary per customer for a given date range
    and optionally filtered by product category. Includes total
    revenue, order count, and average order value.

    Usage:
    -- All categories
    SELECT * FROM get_revenue_summary('2017-01-01', '2018-01-01');

    -- Specific category
    SELECT * FROM get_revenue_summary('2017-01-01', '2018-01-01', 'health_beauty');
===============================================================
*/


CREATE OR REPLACE FUNCTION get_revenue_summary(
    p_start_date DATE,
    p_end_date DATE,
    p_category TEXT DEFAULT NULL
)
RETURNS TABLE(
    customer_unique_id TEXT,
    total_revenue DOUBLE PRECISION,
    order_count BIGINT,
    avg_order_value DOUBLE PRECISION
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT c.customer_unique_id,
           SUM(ot.price) AS total_revenue,
           COUNT(o.order_id) AS order_count,
           AVG(ot.price) AS avg_order_value
    FROM orders o 
    LEFT JOIN order_items ot ON o.order_id = ot.order_id
    LEFT JOIN customers c ON c.customer_id = o.customer_id
    LEFT JOIN products p ON ot.product_id = p.product_id
    LEFT JOIN category_translation ct ON ct.product_category_name = p.product_category_name
    WHERE o.order_purchase_timestamp BETWEEN p_start_date AND p_end_date 
          AND (p_category IS NULL OR ct.product_category_name_english = p_category)
    GROUP BY c.customer_unique_id;
END;
$$;

