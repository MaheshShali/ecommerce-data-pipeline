from pipeline import bronze_ingest,silver_tranform,util 
from pipeline import databaseConfig as db
import logging

logging.basicConfig(
    filename='pipeline.log',
    level=logging.INFO,
    format='%(asctime)s | %(levelname)s | %(message)s'
)

if __name__ == "__main__":
    try:
        db.conn.autocommit = False

        bronze_success = True

        bronze_success &= util.run_stage("Bronze - Create Bronze Tables", bronze_ingest.create_bronze_tables)
        bronze_success &= util.run_stage("Bronze - Load Data", bronze_ingest.load_bronze)

        if bronze_success:
            db.conn.commit()
            print("Bronze committed")

            silver_success = True
            silver_success &= util.run_stage("Silver - Create Silver Tables", silver_tranform.create_silver_tables)
            silver_success &= util.run_stage("Silver - Transform Data", silver_tranform.load_silver)

            if silver_success:
                db.conn.commit()
                print("Silver committed")
            else:
                db.conn.rollback()
                print("Silver failed. Rolled back.")
        else:
            db.conn.rollback()
            print("Bronze failed. Silver will not run.")

    except Exception as e:
        db.conn.rollback()
        print("Pipeline error:", e)

    finally:
        db.cursor.close()
        db.conn.close()
    '''try:
        util.run_stage("Bronze", bronze_ingest.bronze_pipeline)
        db.conn.commit()
        util.run_stage("Silver", silver_tranform.silver_pipeline)
        db.conn.commit()
    except Exception as e:
        db.conn.rollback()
        print(e)
    finally:
        db.cursor.close()
        db.conn.close()'''
