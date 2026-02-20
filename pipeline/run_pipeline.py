import bronze.bronze_ingest as bronze
import databaseConfig as db

if __name__ == "__main__":
    bronze.create_tables()
    bronze.load_bronze()

    db.cursor.close()
    db.conn.close()
