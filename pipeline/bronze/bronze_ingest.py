import databaseConfig as db
import pandas as pd
import os
import re

BRONZE_OUTPUT_FOLDER = 'data/bronze'
bronze_table = ['orders','customers','products']

def run_sql_script(file_path,title):
    try:
        db.conn.autocommit = False
        with open(file_path, 'r', encoding='utf-8') as file:
            sql_script = file.read()

        sql_script_statements = re.split(r'^\s*GO\s*$', sql_script, flags=re.MULTILINE | re.IGNORECASE)
        for statement in sql_script_statements:
            if statement.strip():
                try:
                    db.cursor.execute(statement)
                except Exception as e :
                    print ('Failed to exceute the SQL statement.')
                    print(e)
                    raise
        db.conn.commit()
    except Exception as e :
        db.conn.rollback()
        print(f"Pipeline failed during execution of {file_path}")
        print(e)
        raise
    finally:
        print(title)

def export_bronze_to_csv(table_name):

    output_path = os.path.join(BRONZE_OUTPUT_FOLDER, f"{table_name}.csv")
    if os.path.isfile(output_path) or os.path.islink(output_path):
        os.remove(output_path)

    print(f"Exporting {table_name} → CSV")

    query = f"SELECT * FROM bronze.{table_name}"
    df = pd.read_sql(query, db.conn)
    df.to_csv(output_path, index=False)

    print(f"{table_name}.csv created.")

def create_tables():
    run_sql_script('sql/bronze/ddl_bronze.sql','Creating tables')

def load_bronze():
    run_sql_script('sql/bronze/load_bronze.sql','Inserting values')

