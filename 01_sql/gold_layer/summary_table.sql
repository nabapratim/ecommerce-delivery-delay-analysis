CREATE MATERIALIZED VIEW gold.fact_order_summary AS

WITH order_items_agg AS (
    SELECT 
        order_id,
        COUNT(*) AS total_items,
        SUM(price) AS total_price,
        SUM(freight) AS total_freight
    FROM silver.order_items
    GROUP BY order_id
),

payments_agg AS (
    SELECT 
        order_id,
        SUM(payment_value) AS total_payment,
        COUNT(*) AS payment_count
    FROM silver.order_payments
    GROUP BY order_id
),

stg_orders_filtered AS (
    SELECT 
        o.order_id,
        o.customer_id,
        o.order_status,
        o.purchase_time,
        o.approve_time,
		r.review_score,
        o.delivered_customer_date,
		o.delivered_carrier_date,
        o.estimate_delivery_date
    FROM silver.orders o
	LEFT JOIN silver.order_reviews r 
    ON o.order_id = r.order_id
    WHERE order_status = 'delivered'   -- 🔥 reduces workload
),
orders_filtered AS (
	SELECT
		o.order_id,
        o.customer_id,
        o.order_status,
        o.purchase_time,
        o.approve_time,
		o.review_score,
        o.delivered_customer_date,
        o.estimate_delivery_date,
		o.delivered_carrier_date,
		c.customer_city,
    	c.customer_state
	FROM stg_orders_filtered o
	LEFT JOIN silver.customers c 
    ON o.customer_id = c.customer_id
)
SELECT 
    o.order_id,
    o.customer_id,
    o.order_status,
    o.purchase_time,
    o.approve_time,
    o.delivered_customer_date,
    o.estimate_delivery_date,
	o.delivered_carrier_date,

    -- delivery time
    (o.delivered_customer_date - o.estimate_delivery_date) AS delay_days,
    (o.delivered_customer_date - o.purchase_time) AS delivery_time,
	(o.delivered_carrier_date - o.approve_time) AS seller_delay,
	(o.delivered_customer_date - o.delivered_carrier_date) AS logistic_delay,

	
    -- orders
    oi.total_items,
    oi.total_price,
    oi.total_freight,

    -- payment
    p.total_payment,
    p.payment_count,

    -- review
    o.review_score,

    -- customer
    o.customer_city,
    o.customer_state

FROM orders_filtered o

LEFT JOIN order_items_agg oi 
    ON o.order_id = oi.order_id

LEFT JOIN payments_agg p 
    ON o.order_id = p.order_id;