--index the join columns
CREATE INDEX idx_customers
ON silver.customers(customer_id);

CREATE INDEX idx_orders
ON silver.orders(order_id);

CREATE INDEX idx_order_items
ON silver.order_items(order_id);

CREATE INDEX idx_order_reviews
ON silver.order_reviews(order_id);

CREATE INDEX idx_products
ON silver.products(product_id);
