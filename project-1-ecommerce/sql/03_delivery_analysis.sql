WITH state_orders as (
  SELECT COUNT(od.order_id) as total_orders,
         seller_state,
         COUNT(CASE WHEN order_delivered_customer_date>order_estimated_delivery_date then 1 END) as late_orders
  FROM orders_delivered od 
  JOIN order_items ot ON od.order_id=ot.order_id
  JOIN sellers s ON ot.seller_id=s.seller_id
  GROUP BY(seller_state)
)
SELECT seller_state,
       total_orders,
       late_orders,
       ROUND((late_orders::numeric / total_orders * 100), 1) AS late_rate_pct
FROM state_orders
ORDER BY late_rate_pct DESC; 