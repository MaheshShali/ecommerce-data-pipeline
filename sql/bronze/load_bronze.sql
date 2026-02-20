TRUNCATE TABLE bronze.orders
BULK INSERT bronze.orders
            FROM 'D:\Mahesh_Projects\Data_Engineering_Project\source\olist_orders_dataset.csv'
            WITH(
                FIRSTROW = 2,
                FIELDTERMINATOR = ',',
                ROWTERMINATOR = '0x0a',
                TABLOCK
            );

GO

TRUNCATE TABLE bronze.customers
BULK INSERT bronze.customers
		FROM 'D:\Mahesh_Projects\Data_Engineering_Project\source\olist_customers_dataset.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			FORMAT = 'CSV',
			TABLOCK
		);
GO

TRUNCATE TABLE bronze.products
BULK INSERT bronze.products
		FROM 'D:\Mahesh_Projects\Data_Engineering_Project\source\olist_products_dataset.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			FORMAT = 'CSV',
			TABLOCK
		);

GO

TRUNCATE TABLE bronze.product_category_name_translation
BULK INSERT bronze.product_category_name_translation
		FROM 'D:\Mahesh_Projects\Data_Engineering_Project\source\product_category_name_translation.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

GO

TRUNCATE TABLE bronze.geolocation
BULK INSERT bronze.geolocation
		FROM 'D:\Mahesh_Projects\Data_Engineering_Project\source\olist_geolocation_dataset.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			FORMAT = 'CSV',
			TABLOCK
		);

GO

TRUNCATE TABLE bronze.order_items
BULK INSERT bronze.order_items
		FROM 'D:\Mahesh_Projects\Data_Engineering_Project\source\olist_order_items_dataset.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			FORMAT = 'CSV',
			TABLOCK
		);

GO

TRUNCATE TABLE bronze.sellers
BULK INSERT bronze.sellers
		FROM 'D:\Mahesh_Projects\Data_Engineering_Project\source\olist_sellers_dataset.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			FORMAT = 'CSV',
			TABLOCK
		);

GO

TRUNCATE TABLE bronze.order_payments
BULK INSERT bronze.order_payments
		FROM 'D:\Mahesh_Projects\Data_Engineering_Project\source\olist_order_payments_dataset.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			FORMAT = 'CSV',
			TABLOCK
		);
