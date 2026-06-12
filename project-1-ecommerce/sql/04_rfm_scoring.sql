WITH rfm_base as (
  SELECT customer_unique_id,
         MAX(o.order_purchase_timestamp) as recency,
         COUNT(o.order_id) as frequency,
         SUM(price) as monetary
  FROM orders_delivered od 
  JOIN order_items ot ON od.order_id=ot.order_id
  JOIN orders o ON ot.order_id=o.order_id
  JOIN customers c ON o.customer_id=c.customer_id
  GROUP BY (c.customer_unique_id)
),
rfm_scores as (
  SELECT customer_unique_id,
      recency,
      frequency,
      monetary,
      NTILE(5)OVER(ORDER BY recency DESC) as r_score,
      NTILE(5)OVER(ORDER BY frequency ASC) as f_score,
      NTILE(5) OVER(ORDER BY monetary) as m_score
  FROM rfm_base
)
SELECT * FROM rfm_scores
LIMIT 10;