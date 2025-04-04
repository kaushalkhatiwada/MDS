import pyspark
from pyspark.sql import SparkSession
from pymongo import MongoClient
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def load_to_mongodb(df):
    try:
        logger.info("Connecting to MongoDB...")

        # Connect to MongoDB (update if needed)
        client = MongoClient("mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.4.0")
        db = client["etl"]  # Database name
        collection = db["tweets"]  # Collection name

        # Convert PySpark DataFrame to Pandas before inserting into MongoDB
        pandas_df = df.toPandas()
        records = pandas_df.to_dict(orient="records")

        # Insert records into MongoDB
        collection.insert_many(records)

        logger.info(f"Inserted {len(records)} records into MongoDB successfully.")

    except Exception as e:
        logger.error(f"Error while inserting into MongoDB: {str(e)}")

