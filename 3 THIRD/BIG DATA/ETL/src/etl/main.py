# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def run_etl():
    try:
        # Step 1: Extract data
        logger.info("Starting ETL pipeline...")
        extracted_data = extract()  # Extract data from CSV
        if extracted_data is None:
            logger.error("Data extraction failed. Exiting pipeline.")
            return

        # Step 2: Transform data
        logger.info("Starting data transformation...")
        transformed_data = transform(extracted_data)  # Transform the data
        if transformed_data is None:
            logger.error("Data transformation failed. Exiting pipeline.")
            return

        # Step 3: Load data to MongoDB
        logger.info("Starting data loading to MongoDB...")
        load_to_mongodb(transformed_data)  # Load the transformed data into MongoDB

        logger.info("ETL pipeline completed successfully.")

    except Exception as e:
        logger.error(f"Error in ETL pipeline: {str(e)}")

if __name__ == "__main__":
    run_etl()