-- ================================
-- orders
-- ================================

-- check nulls or duplicates of order_id 
SELECT order_id,COUNT(*)
FROM orders
GROUP BY order_id
HAVING COUNT(*)>1 OR order_id IS NULL; --none

SELECT customer_id,COUNT(*)
FROM orders
GROUP BY customer_id
HAVING COUNT(*)>1 OR customer_id IS NULL; --none, this customer_id is order-scoped

-- Date Inconsistency

 -- Check: Approval timestamp should precede carrier delivery date of the order
SELECT *
FROM orders
WHERE order_approved_at>order_delivered_carrier_date
      OR order_approved_at>order_delivered_customer_date;

    /*Finding: 97,985 rows flagged with approval AFTER carrier pickup, 
    ranging from minutes to multiple days. Likely a data quality issue 
    in the source system — order_approved_at may not reflect the actual 
    business approval event. Flag for further investigation*/

-- ================================
-- order_items
-- ================================

--NULL or Negative prices and freight values
SELECT *
FROM order_items
WHERE price<0 OR price IS NULL; --none

SELECT *
FROM order_items
WHERE freight_value IS NULL OR freight_value<0; --none

--All order_items and order_payments should reference a valid order_id in the orders table
SELECT order_id 
FROM order_items ot
WHERE ot.order_id NOT IN (
  SELECT order_id FROM orders
); -- none

-- ================================
-- order_payments
-- ================================

SELECT order_id 
FROM order_payments op
WHERE op.order_id NOT IN (
  SELECT order_id FROM orders
); --none

-- Flag orders with undefined payment type
SELECT DISTINCT payment_type
FROM order_payments;

SELECT COUNT(*) 
FROM order_payments 
WHERE payment_type = 'not_defined'; 
-- Finding: 3 records have payment_type = 'not_defined'. 
-- Minor data quality issue, negligible impact on analysis.

-- Invalid payment values
SELECT *
FROM order_payments
WHERE payment_value<0 OR payment_value IS NULL; --none

-- ================================
-- order_reviews
-- ================================

-- Review scores should be between 1 and 5
SELECT DISTINCT review_score
FROM order_reviews; -- all scores are valid 

--All order_reviews should reference a valid order_id in the orders table
SELECT review_id
FROM order_reviews orev
WHERE orev.order_id NOT IN (
  SELECT order_id FROM orders
);--none

-- ================================
-- products
-- ================================

-- Product dimensions and weight should be positive values
SELECT *
FROM products 
WHERE product_name_lenght<=0 OR product_description_lenght<=0 OR product_photos_qty<=0 
    OR product_weight_g<=0 OR product_length_cm<=0 OR product_height_cm<=0 OR product_width_cm<=0;
   -- Finding: 4 products have product_weight_g = 0, indicating missing weight data 


