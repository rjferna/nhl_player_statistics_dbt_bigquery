import json
import os
import sys
import time
import subprocess
from datetime import datetime
from gcp_common import list_files_in_bucket
from logger_common import set_logger

def run_dbt_command(command, dbt_project_dir):
    logger.info(f"Executing DBT Macro...")

    # Change to dbt project directory")
    os.chdir(dbt_project_dir)

    logger.info(f"DBT Command: {command}")

    result = subprocess.run(command, shell=True, capture_output=True, text=True)

    if result.returncode == 0:
        logger.info(f"Command succeeded: {result.stdout}")
        logger.info("Sleeping for 5 seconds...")
        time.sleep(5)
        
    else:
        logger.info(f"Command failed: {result.stderr}")
        sys.exit(1)

try:
    now = datetime.now()
    formatted_date = now.strftime("%Y%m%d%H%M%S")
    
    
    # Get Config values
    conf =  json.loads(open("<config file path>", "r").read())

    # Setup Logger
    logging_path =  conf.get("logging_path")
    log_file = "log_file_" + str(formatted_date) + ".log"
    logger = set_logger(logging_path, log_file)

    # GCP details from config file
    logger.info(f"Gather GCP details...")
    gcp_bucket_name = conf.get("gcp_bucket_name")
    gcp_keyfile = conf.get("gcp_credentials")
    dbt_project_path =  conf.get("dbt_proj_path")

    logger.info(f"Accessing GCP Bucket...")

    result = list_files_in_bucket(gcp_bucket_name, gcp_keyfile)

    logger.info(f"Files from GCP Bucket: {result}")

    for table in range(0, len(result)):
        table_to_pass = result[table].split('.')[0]

        # Define the dbt command to run macro with passed value
        dbt_macro_command = f"dbt run-operation create_external_table_automated --args '{{\"value\":\"{table_to_pass}\"}}'"
        
        # Run dbt command
        run_dbt_command(dbt_macro_command, dbt_project_path)

    logger.info(f"#-------------------- END --------------------#")
    sys.exit(0)

except Exception as e:
    logger.info(f'{e}')
