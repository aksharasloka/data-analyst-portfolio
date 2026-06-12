import sys
sys.path.append('/Users/aksharadarapaneni/data-analyst-portfolio/project-1-ecommerce')
from data_loader import load_data
from sqlalchemy import create_engine
import os
from dotenv import load_dotenv

load_dotenv('/Users/aksharadarapaneni/data-analyst-portfolio/project-1-ecommerce/.env')
engine = create_engine(os.getenv('NEON_DATABASE_URL'))

orders, order_items, order_payments, order_reviews, products, sellers, customers, category_translation, orders_delivered = load_data()

print("Loading tables to Neon...")

orders.to_sql('orders', engine, if_exists='replace', index=False)
print("orders done")

order_items.to_sql('order_items', engine, if_exists='replace', index=False)
print("order_items done")

order_payments.to_sql('order_payments', engine, if_exists='replace', index=False)
print("order_payments done")

order_reviews.to_sql('order_reviews', engine, if_exists='replace', index=False)
print("order_reviews done")

products.to_sql('products', engine, if_exists='replace', index=False)
print("products done")

sellers.to_sql('sellers', engine, if_exists='replace', index=False)
print("sellers done")

customers.to_sql('customers', engine, if_exists='replace', index=False)
print("customers done")

category_translation.to_sql('category_translation', engine, if_exists='replace', index=False)
print("category_translation done")

orders_delivered.to_sql('orders_delivered', engine, if_exists='replace', index=False)
print("orders_delivered done")

print("All tables loaded to Neon successfully!")