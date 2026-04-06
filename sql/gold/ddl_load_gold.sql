IF OBJECT_ID('gold.dim_customers', 'U') IS NOT NULL
    DROP TABLE gold.dim_customers;
CREATE TABLE gold.dim_customers (
	customer_key INT IDENTITY(1,1) PRIMARY KEY,
    customer_id VARCHAR(50),
    customer_unique_id VARCHAR(50),
    zip_code VARCHAR(10),
    city VARCHAR(100),
    state VARCHAR(10),
    longitude DECIMAL(10,6),
    latitude DECIMAL(10,6)
)

GO

IF OBJECT_ID('gold.dim_products', 'U') IS NOT NULL
    DROP TABLE gold.dim_products;
CREATE TABLE gold.dim_products ( 
	product_key INT IDENTITY(1,1) PRIMARY KEY,
	product_id NVARCHAR(100),
	category_name NVARCHAR(80),
	weight_g DECIMAL(10,2),
    length_cm DECIMAL(10,2),
    height_cm DECIMAL(10,2),
    width_cm DECIMAL(10,2),
    total_volume_cm3 DECIMAL(12,2),
    has_category BIT
);

GO

IF OBJECT_ID('gold.dim_date', 'U') IS NOT NULL
    DROP TABLE gold.dim_date;

CREATE TABLE gold.dim_date (
    date_key INT PRIMARY KEY,              -- YYYYMMDD
    full_date DATE NOT NULL,
    day_number INT,
    day_name NVARCHAR(20),
    day_of_week INT,                       -- 1=Monday style
    week_of_year INT,
    month_number INT,
    month_name NVARCHAR(20),
    quarter_number INT,
    year_number INT,
    is_weekend BIT,
    is_month_end BIT,
    is_month_start BIT
);



