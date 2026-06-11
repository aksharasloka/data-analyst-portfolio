import pandas as pd
import numpy as np

def load_data():  

    # Load all CSVs
    customers = pd.read_csv("/Users/aksharadarapaneni/data-analyst-portfolio/project-1-ecommerce/data/olist_customers_dataset.csv")
    order_items = pd.read_csv("/Users/aksharadarapaneni/data-analyst-portfolio/project-1-ecommerce/data/olist_order_items_dataset.csv")
    order_payments = pd.read_csv("/Users/aksharadarapaneni/data-analyst-portfolio/project-1-ecommerce/data/olist_order_payments_dataset.csv")
    order_reviews= pd.read_csv("/Users/aksharadarapaneni/data-analyst-portfolio/project-1-ecommerce/data/olist_order_reviews_dataset.csv")
    orders = pd.read_csv("/Users/aksharadarapaneni/data-analyst-portfolio/project-1-ecommerce/data/olist_orders_dataset.csv")
    products = pd.read_csv("/Users/aksharadarapaneni/data-analyst-portfolio/project-1-ecommerce/data/olist_products_dataset.csv")
    sellers= pd.read_csv("/Users/aksharadarapaneni/data-analyst-portfolio/project-1-ecommerce/data/olist_sellers_dataset.csv")
    category_translation = pd.read_csv("/Users/aksharadarapaneni/data-analyst-portfolio/project-1-ecommerce/data/product_category_name_translation.csv")

    #drop null values
    products.dropna(subset=['product_category_name'],inplace=True)

    # Convert date columns to datetime
    orders['order_purchase_timestamp']=pd.to_datetime(orders['order_purchase_timestamp'])
    orders['order_delivered_carrier_date']=pd.to_datetime(orders['order_purchase_timestamp'])
    orders['order_delivered_customer_date']=pd.to_datetime(orders['order_delivered_customer_date'])
    orders['order_estimated_delivery_date']=pd.to_datetime(orders['order_estimated_delivery_date']) 
    orders['order_approved_at']=pd.to_datetime(orders['order_approved_at'])

    # Filter to delivered orders
    orders_delivered = orders[orders['order_status']=='delivered'].copy()
    
    # Merge English category names into products
    products=products.merge(category_translation,on='product_category_name')
    
    return orders, order_items, order_payments, order_reviews, products, sellers, customers, category_translation, orders_delivered