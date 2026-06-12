WITH one_time_orders as ( SELECT customer_unique_id,SUM(price) as revenue,COUNT(od.order_id)
FROM orders_delivered od 
JOIN order_items ot ON od.order_id=ot.order_id
JOIN orders o ON ot.order_id=o.order_id
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY customer_unique_id
HAVING COUNT(DISTINCT od.order_id)=1
)
SELECT SUM(revenue) as leakage_revenue,
    (SELECT SUM(price) FROM order_items) as total_revenue,
    ROUND((SUM(revenue) / (SELECT SUM(price) FROM order_items) * 100)::numeric, 1) as leakage_pct
FROM one_time_orders;