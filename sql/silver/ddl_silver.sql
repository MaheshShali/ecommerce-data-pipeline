IF OBJECT_ID('silver.orders','U') IS NOT NULL
    DROP TABLE silver.orders

CREATE TABLE silver.orders (
    order_id NVARCHAR(80),
    customer_id NVARCHAR(80),
    order_status NVARCHAR(50),
    order_purchase_timestamp DATETIME2(0),
    order_approve_date DATETIME2(0),
    order_delivered_carrier_date DATETIME2(0),
    order_delivered_customer_date DATETIME2(0),
    order_estimated_delivery_date DATE
);

GO

IF OBJECT_ID('silver.customers','U') IS NOT NULL
    DROP TABLE silver.customers

CREATE TABLE silver.customers(
  customer_id NVARCHAR(80),
  customer_unique_id NVARCHAR(80),
  customer_zip_code_prefix NVARCHAR(5),
  customer_city NVARCHAR(50),
  customer_state NVARCHAR(30)
);

GO

IF OBJECT_ID('silver.products','U') IS NOT NULL
    DROP TABLE silver.products
CREATE TABLE silver.products(
    product_id VARCHAR(100),
    product_category_name VARCHAR(100),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g DECIMAL(5,0),
    product_length_cm DECIMAL(5,0),
    product_height_cm DECIMAL(5,0),
    product_width_cm DECIMAL(5,0),
    product_volume_cm3 DECIMAL(10,0),
    is_missing_category BIT
);

GO

IF OBJECT_ID('silver.order_items','U') IS NOT NULL
    DROP TABLE silver.order_items
CREATE TABLE silver.order_items (
    order_id NVARCHAR(100),
    product_id NVARCHAR(100),
    seller_id NVARCHAR(100),
    shipping_limit_date datetime2(0),
    price money,
    freight_value decimal(5,2)
);

GO

IF OBJECT_ID('silver.sellers','U') IS NOT NULL
    DROP TABLE silver.sellers
CREATE TABLE silver.sellers (
    seller_id NVARCHAR(80),
    seller_zip_code_prefix NVARCHAR(5),
    seller_city VARCHAR(50),
    seller_state VARCHAR(5)
);

GO

IF OBJECT_ID('silver.order_payments','U') IS NOT NULL
    DROP TABLE silver.order_payments
CREATE TABLE silver.order_payments (
    order_id VARCHAR(80),
    payment_sequential INT,
    payment_type VARCHAR(50),
    payment_installments INT,
    payment_value money
);

GO

IF OBJECT_ID('silver.geolocation','U') IS NOT NULL
    DROP TABLE silver.geolocation
CREATE TABLE silver.geolocation (
    geolocation_zip_code_prefix VARCHAR(5),
    geolocation_lat FLOAT,
    geolocation_lng FLOAT
);