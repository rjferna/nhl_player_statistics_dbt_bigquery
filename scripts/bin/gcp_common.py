from google.cloud import storage
from google.oauth2 import service_account


def list_files_in_bucket(bucket_name, keyfile_path):
    # Initialize a client with the service account keyfile
    storage_client = storage.Client.from_service_account_json(keyfile_path)
    
    # Get the bucket
    bucket = storage_client.bucket(bucket_name)
    
    # List all objects in the bucket
    blobs = bucket.list_blobs()

    bucket_items = []
    files = []

    for blob in blobs:
        bucket_items.append(blob.name)
    
    # Clean Name
    for val in range(0, len(bucket_items)):
        if  len(bucket_items[val]) >= 21:
            #files.append(bucket_items[val].split('input/nhl-game-data/')[1].split('.')[0]) # Removes bucket path and file type extension
            files.append(bucket_items[val].split('input/nhl-game-data/')[1])

    return files

def upload_to_bucket(bucket_name, source_file_name, destination_blob_name, keyfile_path): 
    # Initialize a client with the service account keyfile 
    storage_client = storage.Client.from_service_account_json(keyfile_path) 
    
    # Get the bucket 
    bucket = storage_client.bucket(bucket_name) 
    
    # Create a blob and upload the file to the bucket 
    blob = bucket.blob(destination_blob_name) 
    blob.upload_from_filename(source_file_name) 
    
    print(f"File {source_file_name} uploaded to {destination_blob_name}.")


def query_dataset(query, keyfile_path):
    # Path to your service account keyfile
    keyfile = keyfile_path

    # Create credentials using the service account keyfile
    credentials = service_account.Credentials.from_service_account_file(keyfile)

    # Initialize a BigQuery client
    client = bigquery.Client(credentials=credentials, project=credentials.project_id)

    # Execute the query
    query_job = client.query(query)

    # Fetch the results
    results = query_job.result()

    # Store results in a dictionary 
    result_dict = {} 
    for row in results: 
        row_dict = {key: row[key] for key in row.keys()} 
        result_dict[row[0]] = row_dict # Using the first column's value as the dictionary key # Print the results

    return result_dict