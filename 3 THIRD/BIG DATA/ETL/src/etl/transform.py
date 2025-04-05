import re
import pyspark
from pyspark.sql import SparkSession
import nltk
from nltk.corpus import stopwords
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Initialize stop words list
stop_words = set(stopwords.words("english"))

def clean_text(text):
    """
    Function to clean tweet text by removing URLs, mentions, and special characters.
    """
    text = re.sub(r"http\S+|www\S+", "", text)  # Remove URLs
    text = re.sub(r"@\w+", "", text)  # Remove mentions
    text = re.sub(r"[^\w\s]", "", text)  # Remove special characters
    text = re.sub(r"\d+", "", text)  # Remove numbers
    text = re.sub(r"\s+", " ", text).strip()  # Remove extra spaces
    # Remove stop words
    text = ' '.join([word for word in text.split() if word.lower() not in stop_words])
    return text.lower()


def transform(df):
    try:
        df.show(5)
        logger.info("Starting data transformation...")
        df_cleaned = clean_text(df)
        
        logger.info("Data transformation completed successfully.")

        # filename = "transformed.csv"
        # df_cleaned.write.csv(f"../../data/transformed/{filename}", header=True, mode='overwrite')  # Save as CSV, overwrite if exists
        # logger.info(f"Transformed data saved to {filename}")
        return df_cleaned

    except Exception as e:
        logger.error(f"Error during transformation: {str(e)}")
        return None

if __name__ == "__main__":
    # Initialize Spark Session
    spark = SparkSession.builder.appName("TransformEnv").getOrCreate()
    
    # Load extracted data
    extracted_data = spark.read.csv("../../data/tweet_sentiment.csv", header=True, inferSchema=True)
    
    # Transform data
    transformed_data = transform(extracted_data)

    if transformed_data:
        transformed_data.show(5)
