TRUNCATE TABLE silver.orders
INSERT INTO silver.orders (
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approve_date,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date
)
(SELECT 
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approve_date,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date
FROM 
(SELECT 
        REPLACE(order_id,'"','') order_id,
        REPLACE(customer_id,'"','') customer_id,
        order_status,
        CAST(order_purchase_timestamp as datetime2(0)) order_purchase_timestamp,
        CAST(order_approved_at AS datetime2(0)) order_approve_date,
        CAST(order_delivered_carrier_date AS datetime2(0)) order_delivered_carrier_date ,
        CAST(order_delivered_customer_date AS datetime2(0)) order_delivered_customer_date,
        CAST(order_estimated_delivery_date AS date) order_estimated_delivery_date,
        CASE
            WHEN order_status = 'delivered'
                 AND order_delivered_customer_date IS NULL
            THEN 1
            ELSE 0
        END AS is_data_issue
    FROM bronze.orders)t
WHERE is_data_issue != 1
);

GO 

TRUNCATE TABLE silver.customers
INSERT INTO silver.customers(
	customer_id,
	customer_unique_id,
	customer_zip_code_prefix,
	customer_city,
	customer_state 
)
(
SELECT 
	customer_id,
	customer_unique_id,
	customer_zip_code_prefix,
	customer_city,
	UPPER(customer_state)
FROM bronze.customers
);

GO

TRUNCATE TABLE silver.products
INSERT INTO silver.products(
    product_id,
    product_category_name,
    product_name_length,
    product_description_length,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm,
    product_volume_cm3,
    is_missing_category 
)
(SELECT 
    product_id,
    COALESCE(pcn.product_category_name_english,po.product_category_name,'n/a') as product_category_name, ------- From product_category_name_translation 
    CAST(product_name_length as INT) product_name_length,
    CAST(product_description_length as INT) product_description_length,
    CAST(product_photos_qty as INT) product_photos_qty,
    CAST(product_weight_g as decimal) product_weight_g,
    CAST(product_length_cm as decimal)product_length_cm,
    CAST(product_height_cm as decimal) product_height_cm,
    CAST(product_width_cm as decimal)product_width_cm,
    product_volume_cm_3 = CAST(product_length_cm as decimal) * CAST(product_height_cm as decimal) * CAST(product_width_cm as decimal) ,
    CASE 
        WHEN po.product_category_name IS NULL THEN 1
        ELSE 0
    END AS is_missing_category
FROM bronze.products po
LEFT JOIN bronze.product_category_name_translation pcn
ON po.product_category_name = pcn.product_category_name
WHERE product_weight_g >= 0 or product_height_cm > 0 or product_length_cm > 0 or product_width_cm > 0);

GO

TRUNCATE TABLE silver.order_items
INSERT INTO silver.order_items(
	order_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value
)
(SELECT 
	order_id,
	product_id,
	seller_id,
	CAST(shipping_limit_date as datetime2(0))shipping_limit_date,
	CAST(price as money) price,
	CAST(freight_value as decimal(5,2))freight_value
FROM bronze.order_items
WHERE order_item_id = 1);

GO 

TRUNCATE TABLE silver.sellers
INSERT INTO silver.sellers(
	seller_id,
	seller_zip_code_prefix,
	seller_city,
	seller_state
)
(SELECT 
	seller_id,
	seller_zip_code_prefix,
	seller_city,
	UPPER(seller_state)
FROM bronze.sellers);

GO 

TRUNCATE TABLE silver.order_payments
INSERT INTO silver.order_payments(
	order_id,
	payment_sequential,
	payment_type,
	payment_installments,
	payment_value
)
(SELECT 
	order_id,
	payment_sequential,
	CASE payment_type 
		WHEN 'credit_card' THEN 'Credit_Card'
		WHEN 'debit_card' THEN 'Debit_Card'
		WHEN 'voucher' THEN 'Voucher'
		WHEN 'boleto' THEN 'Boleto'
		ELSE 'n/a'
	END as payment_type,
	payment_installments,
	payment_value
FROM bronze.order_payments);

GO

TRUNCATE TABLE silver.geolocation
INSERT INTO silver.geolocation(
	geolocation_zip_code_prefix,
	geolocation_lat,
	geolocation_lng
)
(SELECT 
	geolocation_zip_code_prefix,
	AVG(CAST(geolocation_lat as FLOAT)) geolocation_lat,
	AVG(CAST(geolocation_lng as FLOAT)) geolocation_lng
FROM bronze.geolocation
GROUP BY geolocation_zip_code_prefix);












