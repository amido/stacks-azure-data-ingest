import logging
from pysparkle.logger import setup_logger

WORKLOAD_NAME = "processing_andytest"

logger_library = "pysparkle"
logger = logging.getLogger(logger_library)


def etl_main() -> None:
    """Execute data processing and transformation jobs."""
    logger.info(f"Running {WORKLOAD_NAME} processing...")

    #######################
    # Add processing here #
    #######################

    logger.info(f"Finished: {WORKLOAD_NAME} processing.")


if __name__ == "__main__":
    setup_logger(name=logger_library, log_level=logging.INFO)
    etl_main()