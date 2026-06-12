WITH monthly_revenue as (
  SELECT DATE_TRUNC('month', order_purchase_timestamp) AS month,SUM(price) as revenue
  FROM orders_delivered od
  JOIN order_items ot ON od.order_id=ot.order_id
  GROUP BY DATE_TRUNC('month',order_purchase_timestamp)
)
SELECT month,
       revenue,
       LAG(revenue)OVER(ORDER BY month) as prev_month_revenue,
      ROUND(
    ((revenue - LAG(revenue) OVER (ORDER BY month)) /  LAG(revenue) OVER (ORDER BY month) * 100)::numeric, 1) AS mom_growth_pct
FROM monthly_revenue
ORDER BY month;