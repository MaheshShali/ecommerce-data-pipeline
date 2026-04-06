from pipeline import util

def create_silver_tables():
    util.run_sql_script('sql/silver/ddl_silver.sql','Creating Silver tables')
    
def load_silver():
    util.run_sql_script('sql/silver/load_silver.sql','Inserting values to silver table')

def silver_pipeline():
    create_silver_tables()
    load_silver()