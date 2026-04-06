-------------------------------------ORDER TABEL -------------------------------------------------
--Remove " char from the 
SELECT 
    REPLACE(order_id,'"',''),
    REPLACE(customer_id,'"','')
FROM bronze.orders

--Test
SELECT 
    order_id,
    customer_id 
FROM silver.orders
WHERE order_id LIKE '"%' or customer_id LIKE '"%'

--- Checking for Unique values for  Primary Key 
SELECT 
    REPLACE(order_id,'"',''),
    COUNT(*)
FROM bronze.orders 
GROUP BY REPLACE(order_id,'"','')
HAVING COUNT(*) > 1;
 --TEST--
SELECT 
    order_id,
    COUNT(*)
FROM silver.orders 
GROUP BY order_id
HAVING COUNT(*) > 1; 


--REMOVE WHITESPACE if PRESENT
SELECT
order_id
FROM bronze.orders
where order_id != TRIM(order_id)
--- No whitespace are present 


--CHECKING for valid orders
SELECT *
FROM (
SELECT 
order_id,
CASE
    WHEN order_status = 'delivered'
         AND order_delivered_customer_date IS NULL
    THEN 1
    ELSE 0
END AS is_data_issue from bronze.orders) t
where is_data_issue = 1

--test
SELECT *
FROM (
SELECT 
order_id,
CASE
    WHEN order_status = 'delivered'
         AND order_delivered_customer_date IS NULL
    THEN 1
    ELSE 0
END AS is_data_issue from silver.orders) t
where is_data_issue = 1


--------------------- CUSTOMER TABLE --------------------------------


----WHITESPACE---
SELECT customer_id 
FROM bronze.customers
where customer_zip_code_prefix != TRIM(customer_zip_code_prefix)

---Unique Value--
SELECT 
	customer_id,
	COUNT(*)
FROM bronze.customers
GROUP BY customer_id
Having count(*) > 1

--No Nulls
SELECT * 
FROM bronze.customers
where customer_zip_code_prefix is null

--Normalization
SELECT count(*)
FROM bronze.customers
WHERE customer_state != UPPER(customer_state)

-- LENgth and Format Validation 
SELECT 
customer_zip_code_prefix,
customer_city,
LEN(customer_zip_code_prefix)
FROM bronze.customers
WHERE LEN(customer_zip_code_prefix) = 5
AND customer_zip_code_prefix NOT LIKE '%[^0-9]%'


------------------------------ Product TAble -------------------


------Unique Product_id --------
SELECT  * FROM (SELECT 
ROW_NUMBER () OVER( PARTITION BY product_id order by product_id) as rn 
FROM bronze.products) t
WHERE rn > 1

--Invalid Product

SELECT * FROM bronze.products
where product_weight_g <= 0 or product_height_cm <=0 or product_length_cm <=0 or product_width_cm <=0

SELECT * FROM bronze.products
where product_id is NULL


----------------------------ORDER_ITEMS ------------------

SELECT * from bronze.order_items
WHERE order_id is null

-----Remove Duplicate orders 
select * FROM( SELECT order_id,order_item_id, 
ROW_NUMBER() OVER(PARTITION BY order_id order by order_id) Rn
FROM bronze.order_items)t
WHERE order_item_id = rn
---TEST------
select * FROM( SELECT order_id, 
ROW_NUMBER() OVER(PARTITION BY order_id order by order_id) Rn
FROM silver.order_items)t
WHERE rn > 1

--- REMOVE WHITESPACE
SELECT * FROM bronze.order_items
WHERE freight_value != TRIM(freight_value)

----------------------------SELLER table -----------------------------
----Remove WhiteSpace
SELECT * FROM silver.sellers
WHERE seller_id != TRIM(seller_id)


---Check for dupicates
SELECT * FROM (SELECT seller_id,
ROW_NUMBER() OVER(Partition by seller_id order by seller_id) rn
FROM silver.sellers)t
WHERE rn > 1

---Check len of zip code
SELECT * FROM bronze.sellers
WHERE len(seller_zip_code_prefix) != 5

---------------------------------Order_Payments Table---------------------------------------
---Multiple payment for same order valid data
SELECT *, 
ROW_NUMBER() OVER(Partition by order_id order by order_id,payment_sequential)
FROM bronze.order_payments

---Checks for null
SELECT * FROM bronze.order_payments
WHERE payment_value is null

----Payment less than zero
SELECT * FROM bronze.order_payments
WHERE cast(payment_value as money) < 0

---Standardization 
SELECT 
CASE payment_type 
	WHEN 'credit_card' THEN 'Credit_Card'
	WHEN 'debit_card' THEN 'Debit_Card'
	WHEN 'voucher' THEN 'Voucher'
	WHEN 'boleto' THEN 'Boleto'
	ELSE 'n/a'
END
as payment_type 
FROM bronze.order_payments
GROUP BY payment_type

----------------------------------------Geolocation--------------------

--- MUTLiple Lng and lat for a single Zip code so considering the avg out of it 
SELECT 
	geolocation_zip_code_prefix,
	AVG(CAST(geolocation_lat as FLOAT)) geolocation_lat,
	AVG(CAST(geolocation_lng as FLOAT)) geolocation_lng
FROM bronze.geolocation
GROUP BY geolocation_zip_code_prefix

---NULL check for lng and lat 
SELECT 
	geolocation_zip_code_prefix
FROM bronze.geolocation
WHERE geolocation_lat is null