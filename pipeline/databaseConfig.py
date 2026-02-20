import pyodbc

# Connection
conn = pyodbc.connect(
    "DRIVER={SQL Server};"
    "SERVER=LAPTOP-49PDD5CM\SQLEXPRESS;"
    "DATABASE=ecommerce_DWH;"
    "Trusted_Connection=yes;"
)

# cursor object 
cursor = conn.cursor()