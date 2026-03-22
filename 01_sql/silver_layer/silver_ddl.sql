DROP TABLE silver.customers;

CREATE TABLE silver.customers(
	customer_id  VARCHAR(50),
	customer_unique_id VARCHAR(50),
	zip_code INT,
	customer_city VARCHAR(50),
	customer_state VARCHAR(50),
	updated_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE silver.geolocation;

CREATE TABLE silver.geolocation(
	zip_code  INT,
	latitude FLOAT,
	longitutde FLOAT,
	city VARCHAR(50),
	state VARCHAR(50),
	updated_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE silver.order_items;

CREATE TABLE silver.order_items(
	order_id VARCHAR(50),
	order_item_id VARCHAR(50),
	product_id VARCHAR(50),
	seller_id VARCHAR(50),
	shipping_date  DATE,
	price numeric(10,2),
	freight numeric(10,2),
    updated_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE silver.order_payments;

CREATE TABLE silver.order_payments(
    order_id  VARCHAR(50),
	order_sequences  INT,
	payment_type  VARCHAR(50),
	payment_installment INT,
	payment_value numeric(10,2),
	updated_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE silver.order_reviews;

CREATE TABLE silver.order_reviews(
	review_id VARCHAR(50),
	order_id VARCHAR(50),
	review_score INT,
	comment_title VARCHAR(50),
    comment_message VARCHAR(50),
	creation_date DATE,
	answer_date DATE,
	updated_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE silver.orders;

CREATE TABLE silver.orders(
	order_id  VARCHAR(50),
	customer_id VARCHAR(50),
	order_status  VARCHAR(50),
	purchase_time  TIMESTAMP,
	approve_time TIMESTAMP,
	delivered_carrier_date TIMESTAMP,
	delivered_customer_date TIMESTAMP,
	estimate_delivery_date TIMESTAMP,
	updated_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE silver.products;

CREATE TABLE silver.products(
	product_id VARCHAR(50),
	category_name VARCHAR(50),
	name_lenght INT,
	description_length INT,
	photos_qty INT,
	weight_g INT,
	length_cm INT,
	height_cm INT,
	width_cm INT,
	updated_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE silver.sellers;

CREATE TABLE silver.sellers(
	seller_id VARCHAR(50),
	seller_zip_code INT,
	seller_city VARCHAR(50),
	seller_state VARCHAR(50),
    updated_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE silver.product_name_transl;

CREATE TABLE silver.product_name_transl(
    product_category_name  VARCHAR(50),
	product_category_name_eng  VARCHAR(50),
	updated_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);



































