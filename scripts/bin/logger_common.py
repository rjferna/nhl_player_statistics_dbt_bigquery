import logging

def set_logger(log_file_location, log_file_name):
    # To set up logger
    logger = logging.getLogger("EXECUTION")
    logger.setLevel(logging.DEBUG)

    # To set up logger handler
    handler = logging.FileHandler(log_file_location + log_file_name)
    handler.setLevel(logging.DEBUG)
    formatter = logging.Formatter("%(asctime)s - %(name)s - %(levelname)s - %(message)s")
    handler.setFormatter(formatter)

    # To add handler with logger
    logger.addHandler(handler)

    return logger