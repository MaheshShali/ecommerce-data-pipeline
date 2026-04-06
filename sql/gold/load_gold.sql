TRUNCATE TABLE gold.dim_customers
INSERT INTO gold.dim_customers (
	customer_id,
    customer_unique_id,
    zip_code,
    city,
    state,
    longitude,
    latitude
)
SELECT 
	cus.customer_id AS customer_id,
	cus.customer_unique_id as customer_unique_id,
	cus.customer_zip_code_prefix AS zip_code,
	cus.customer_city AS city,
	cus.customer_state AS state,
	geo.geolocation_lng AS longitude,
	geo.geolocation_lat AS latitude
FROM silver.customers cus
LEFT JOIN silver.geolocation geo
ON cus.customer_zip_code_prefix = geo.geolocation_zip_code_prefix;


GO 

TRUNCATE TABLE gold.dim_products
INSERT INTO gold.dim_products(
	product_id,
	category_name,
	weight_g,
	length_cm,
	height_cm,
	width_cm,
	total_volume_cm3,
	has_category
)
SELECT
	product_id,
	product_category_name AS category_name,
	product_weight_g AS weight_g,
	product_length_cm AS length_cm,
	product_height_cm AS height_cm,
	product_width_cm AS width_cm,
	product_volume_cm3 AS total_volume_cm3,
	is_missing_category AS has_category
FROM silver.products;

GO

DECLARE @StartDate DATE = '2015-01-01';
DECLARE @EndDate   DATE = '2025-12-31';

WITH DateSeries AS (
    SELECT @StartDate AS d
    UNION ALL
    SELECT DATEADD(DAY, 1, d)
    FROM DateSeries
    WHERE d < @EndDate
)

TRUNCATE TABLE gold.dim_products
INSERT INTO gold.dim_date
SELECT
    CONVERT(INT, FORMAT(d, 'yyyyMMdd')) AS date_key,
    d AS full_date,
    DAY(d) AS day_number,
    DATENAME(WEEKDAY, d) AS day_name,
    DATEPART(WEEKDAY, d) AS day_of_week,
    DATEPART(WEEK, d) AS week_of_year,
    MONTH(d) AS month_number,
    DATENAME(MONTH, d) AS month_name,
    DATEPART(QUARTER, d) AS quarter_number,
    YEAR(d) AS year_number,
    CASE WHEN DATENAME(WEEKDAY, d) IN ('Saturday','Sunday') THEN 1 ELSE 0 END,
    CASE WHEN EOMONTH(d) = d THEN 1 ELSE 0 END,
    CASE WHEN DAY(d) = 1 THEN 1 ELSE 0 END
FROM DateSeries
OPTION (MAXRECURSION 0);



--***Fact**
SELECT
	ord.order_id,
    ord.[customer_id]
    ,ord.[order_status]
    ,ord.[order_purchase_timestamp]
    ,ord.[order_approve_date]
    ,ord.[order_delivered_carrier_date]
    ,ord.[order_delivered_customer_date]
    ,ord.[order_estimated_delivery_date],
	ord_det.product_id,
	ord_det.seller_id
FROM silver.orders ord
Left JOIN (SELECT 
ord_itm.order_id,
ord_itm.product_id,
ord_itm.shipping_limit_date,
ord_itm.price,
ord_itm.freight_value,
ord_itm.seller_id,
sell.seller_city,
sell.seller_state,
sell.seller_zip_code_prefix
FROM silver.order_items ord_itm 
JOIN silver.sellers sell  --Very order item as seller id 
ON ord_itm.seller_id = sell.seller_id) ord_det
ON ord.order_id = ord_det.order_id