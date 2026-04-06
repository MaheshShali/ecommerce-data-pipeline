from pipeline import util

def create_bronze_tables():
    util.run_sql_script('sql/bronze/ddl_bronze.sql','Creating Bronze tables')
    
def load_bronze():
    util.run_sql_script('sql/bronze/load_bronze.sql','Inserting values to Bronze table')

def bronze_pipeline():
    create_bronze_tables()
    load_bronze()