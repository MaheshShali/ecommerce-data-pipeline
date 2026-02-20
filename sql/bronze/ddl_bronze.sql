IF OBJECT_ID('bronze.orders','U') IS NOT NULL
    DROP TABLE bronze.orders
CREATE TABLE bronze.orders (
    order_id VARCHAR(100),
    customer_id VARCHAR(100),
    order_status VARCHAR(100),
    order_purchase_timestamp VARCHAR(100),
    order_approved_at VARCHAR(100),
    order_delivered_carrier_date VARCHAR(100),
    order_delivered_customer_date VARCHAR(100),
    order_estimated_delivery_date VARCHAR(100)
);

GO

IF OBJECT_ID('bronze.customers','U') IS NOT NULL
    DROP TABLE bronze.customers
CREATE TABLE bronze.customers(
  customer_id VARCHAR(50),
  customer_unique_id VARCHAR(50),
  customer_zip_code_prefix VARCHAR(50),
  customer_city VARCHAR(50),
  customer_state VARCHAR(50)
);

GO

IF OBJECT_ID('bronze.products','U') IS NOT NULL
    DROP TABLE bronze.products
CREATE TABLE bronze.products(
    product_id VARCHAR(100),
    product_category_name VARCHAR(100),
    product_name_length VARCHAR(20),
    product_description_length VARCHAR(20),
    product_photos_qty VARCHAR(20),
    product_weight_g VARCHAR(20),
    product_length_cm VARCHAR(20),
    product_height_cm VARCHAR(20),
    product_width_cm VARCHAR(20)
);

GO

IF OBJECT_ID('bronze.product_category_name_translation','U') IS NOT NULL
    DROP TABLE bronze.product_category_name_translation
CREATE TABLE bronze.product_category_name_translation(
    product_category_name VARCHAR(50),
    product_category_name_english VARCHAR(50)
);

GO 

IF OBJECT_ID('bronze.order_items','U') IS NOT NULL
    DROP TABLE bronze.order_items
CREATE TABLE bronze.order_items (
    order_id VARCHAR(100),
    order_item_id VARCHAR(20),
    product_id VARCHAR(100),
    seller_id VARCHAR(100),
    shipping_limit_date VARCHAR(50),
    price VARCHAR(50),
    freight_value VARCHAR(50)
);

GO

IF OBJECT_ID('bronze.sellers','U') IS NOT NULL
    DROP TABLE bronze.sellers
CREATE TABLE bronze.sellers (
    seller_id VARCHAR(100),
    seller_zip_code_prefix VARCHAR(20),
    seller_city VARCHAR(100),
    seller_state VARCHAR(10)
);

GO

IF OBJECT_ID('bronze.order_payments','U') IS NOT NULL
    DROP TABLE bronze.order_payments
CREATE TABLE bronze.order_payments (
    order_id VARCHAR(100),
    payment_sequential VARCHAR(20),
    payment_type VARCHAR(50),
    payment_installments VARCHAR(20),
    payment_value VARCHAR(50)
);

GO

IF OBJECT_ID('bronze.order_reviews','U') IS NOT NULL
    DROP TABLE bronze.order_reviews
CREATE TABLE bronze.order_reviews (
    review_id VARCHAR(100),
    order_id VARCHAR(100),
    review_score INT,
    review_comment_title VARCHAR(255),
    review_comment_message VARCHAR(MAX),
    review_creation_date DATETIME2,
    review_answer_timestamp DATETIME2
);

GO

IF OBJECT_ID('bronze.geolocation','U') IS NOT NULL
    DROP TABLE bronze.geolocation
CREATE TABLE bronze.geolocation (
    geolocation_zip_code_prefix VARCHAR(20),
    geolocation_lat VARCHAR(50),
    geolocation_lng VARCHAR(50),
    geolocation_city VARCHAR(100),
    geolocation_state VARCHAR(10)
);

