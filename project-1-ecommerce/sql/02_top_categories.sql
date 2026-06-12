SELECT product_category_name_english,SUM(price) as revenue
FROM orders_delivered od 
JOIN order_items ot ON od.order_id=ot.order_id
JOIN products p ON ot.product_id=p.product_id
GROUP BY product_category_name_english
ORDER BY revenue DESC
LIMIT 10;