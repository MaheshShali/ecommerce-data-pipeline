from pipeline import databaseConfig as db
import pandas as pd
import os
import re
import logging
import time

def run_stage(stage_name, stage):
    start = time.time()
    logging.info(f"Starting stage: {stage_name}")
    try:
        stage()
        duration = round(time.time() - start, 2)
        logging.info(f"Completed stage: {stage_name} in {duration}s")
        return True
    except Exception as e:
        logging.error(f"Stage failed: {stage_name} | Error: {str(e)}")
        return False

def run_sql_script(file_path,title):
    try:
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
    except Exception as e :
        print(f"Pipeline failed during execution of {file_path}")
        print(e)
        raise

def export_table_to_csv(table_name,folder):

    output_path = os.path.join(folder, f"{table_name}.csv")
    if os.path.isfile(output_path) or os.path.islink(output_path):
        os.remove(output_path)

    print(f"Exporting {table_name} → CSV")

    query = f"SELECT * FROM bronze.{table_name}"
    df = pd.read_sql(query, db.conn)
    df.to_csv(output_path, index=False)

    print(f"{table_name}.csv created.")