CREATE OR REPLACE PROCEDURE silver.refresh_silver_tables()
LANGUAGE plpgsql
AS $$

BEGIN


INSERT INTO silver.customers(
	customer_id,
	customer_unique_id,
	zip_code,
	customer_city,
	customer_state,
	updated_at
)
select 
	cast(trim("customer_id") as varchar(50)) as customer_id,
	cast(trim("customer_unique_id") as varchar(50)) as customer_unique_id,
	cast("customer_zip_code_prefix" as int) as zip_code,
	cast(lower(unaccent(trim("customer_city"))) as varchar(50)) as customer_city,
	cast(lower(unaccent(trim("customer_state"))) as varchar(50)) as customer_state,
	CURRENT_TIMESTAMP AS updated_at
from bronze.stg_olist_customers_dataset;

INSERT INTO silver.geolocation(
	zip_code,
	latitude,
	longitutde,
	city,
	state,
	updated_at
)
select 
	cast("geolocation_zip_code_prefix" as int) as zip_code,
	cast("geolocation_lat" as float) as latitude,
	cast("geolocation_lng" as float) as longitude,
	cast(lower(unaccent(trim("geolocation_city"))) as varchar(50)) as city,
	cast(lower(unaccent(trim("geolocation_state"))) as varchar(50)) as state,
	CURRENT_TIMESTAMP AS updated_at
from bronze.stg_olist_geolocation_dataset; 


INSERT INTO silver.order_items(
	order_id,
	order_item_id,
	product_id,
	seller_id,
	shipping_date,
	price,
	freight,
    updated_at
)
select 
	cast(trim("order_id") as varchar(50)) as order_id,
	cast("order_item_id" as int ) as order_item_id,
	cast(trim("product_id") as varchar(50)) as product_id,
	cast(trim("seller_id") as varchar(50)) as seller_id,
	cast("shipping_limit_date" as timestamp) as shipping_date,
	cast("price" as numeric(10,2)) as price,
	cast("freight_value" as numeric(10,2)) as freight,
	CURRENT_TIMESTAMP AS updated_at
from bronze.stg_olist_order_items_dataset;  


INSERT INTO silver.order_payments(
	order_id,
	order_sequences,
	payment_type,
	payment_installment,
	payment_value,
	updated_at
)
select 
	cast(trim("order_id") as varchar(50)) as order_id,
	cast("payment_sequential" as int ) as payment_sequences,
	cast(trim("payment_type") as varchar(50)) as payment_type,
	cast("payment_installments" as int ) as payment_installment,
	cast("payment_value" as numeric(10,2)) as payment_value,
	CURRENT_TIMESTAMP AS updated_at
from bronze.stg_olist_order_payments_dataset;  

INSERT INTO silver.order_reviews(
	review_id,
	order_id,
	review_score,
	comment_title,
    comment_message,
	creation_date,
	answer_date,
	updated_at
)
select 
	cast(trim("review_id") as varchar(50)) as review_id,
	cast(trim("order_id") as varchar(50)) as order_id,
	cast("review_score" as int) as review_score,
	cast(trim("review_comment_title") as varchar(50)) as comment_title,
	cast(trim("review_comment_message") as varchar(50)) as comment_message,
	cast("review_creation_date" as timestamp) as creation_date,
	cast("review_answer_timestamp" as timestamp) as answer_date,
	CURRENT_TIMESTAMP AS updated_at
from bronze.stg_olist_order_reviews_dataset;  

INSERT INTO silver.orders(
	order_id,
	customer_id,
	order_status,
	purchase_time,
	approve_time,
	delivered_carrier_date,
	delivered_customer_date,
	estimate_delivery_date,
	updated_at
)
select 
	cast(trim("order_id") as varchar(50)) as order_id,
	cast(trim("customer_id") as varchar(50)) as customer_id,
	cast("order_status" as varchar(50)) as order_status,
	cast("order_purchase_timestamp" as timestamp) as purchase_time,
	cast("order_approved_at" as timestamp) as approve_time,
	cast("order_delivered_carrier_date" as timestamp) as delivered_carrier_date,
	cast("order_delivered_customer_date" as timestamp) as delivered_customer_date,
	cast("order_estimated_delivery_date" as timestamp) as estimate_delivery_date,
	CURRENT_TIMESTAMP AS updated_at
from bronze.stg_olist_orders_dataset;


INSERT INTO silver.products(
	product_id,
	category_name,
	name_lenght,
	description_length,
	photos_qty,
	weight_g,
	length_cm,
	height_cm,
	width_cm,
	updated_at
)
select 
	cast(trim("product_id") as varchar(50)) as product_id,
	cast(trim("product_category_name") as varchar(50)) as category_name,
	cast("product_name_lenght" as int ) as name_length,
	cast("product_description_lenght" as int ) as description_length,
	cast("product_photos_qty" as int ) as photos_qty,
	cast("product_weight_g" as int ) as weight_g,
	cast("product_length_cm" as int ) as length_cm,
	cast("product_height_cm" as int ) as height_cm,
	cast("product_width_cm" as int ) as width_cm,
	CURRENT_TIMESTAMP AS updated_at
from bronze.stg_olist_products_dataset;


INSERT INTO silver.sellers(
	seller_id,
	seller_zip_code,
	seller_city,
	seller_state,
    updated_at
)
select
	cast(trim("seller_id") as varchar(50)) as seller_id,
	cast("seller_zip_code_prefix" as int) as seller_zip_code,
	cast(lower(unaccent(trim("seller_city"))) as varchar(50)) as seller_city,
	cast(lower(unaccent(trim("seller_state"))) as varchar(50)) as seller_state,
	CURRENT_TIMESTAMP AS updated_at
from bronze.stg_olist_sellers_dataset; 


INSERT INTO silver.product_name_transl(
	product_category_name,
	product_category_name_eng,
	updated_at
)
select 	
	cast(trim("product_category_name") as varchar(50)) as product_category_name,
	cast(trim("product_category_name_english") as varchar(50)) as product_category_name_eng,
	CURRENT_TIMESTAMP AS updated_at
from bronze.stg_product_category_name_translation;

END;

$$;





























