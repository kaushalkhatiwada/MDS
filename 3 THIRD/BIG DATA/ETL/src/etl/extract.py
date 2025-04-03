import pyspark
from pyspark.sql import SparkSession
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def extract():
    try:
        spark = SparkSession.builder.appName("EtlEnv").getOrCreate()

        logger.info("Spark session created successfully")

        tweet = spark.read.csv("../../data/tweet_sentiment.csv", header=True, inferSchema=True)
        logger.info("CSV file loaded successfully")

        return tweet
    
    except Exception as e:
        logger.error(f"Error occurred while extracting data: {str(e)}")
        return None