# Edit the accountname and accountkey on line 20
# Edit the container name on line 24

import time
import os

from azure.storage.blob import BlobServiceClient

def download_blob(blob_service_client, container_name, blob_name, destination_path):
    blob_client = blob_service_client.get_blob_client(container=container_name, blob=blob_name)
    with open(destination_path, "wb") as f:
        data = blob_client.download_blob()
        f.write(data.readall())

def list_blobs(blob_service_client, container_name):
    container_client = blob_service_client.get_container_client(container_name)
    blobs = container_client.list_blobs()
    return [blob.name for blob in blobs]

def main():
    # Azure Storage Account connection string
    connection_string = "DefaultEndpointsProtocol=https;AccountName=ACCOUNTNAMEHERE;AccountKey=ACCOUNTKEYHERE;EndpointSuffix=core.windows.net"

    # Azure Blob Storage container name
    container_name = "CONTAINERNAMEHERE"

    # Local directory to save downloaded files
    local_directory = "/opt/kapetriages/"

    # Create a BlobServiceClient
    blob_service_client = BlobServiceClient.from_connection_string(connection_string)

    # Create a ContainerClient
    container_client = blob_service_client.get_container_client(container_name)

    while True:
        # List existing files in the local directory
        local_files = os.listdir(local_directory)

        # List blobs in the Azure Blob Storage container
        blobs = list_blobs(blob_service_client, container_name)

        # Check for new .zip files and download them if they don't exist locally
        for blob_name in blobs:
            if blob_name.endswith(".zip") and blob_name not in local_files:
                destination_path = os.path.join(local_directory, blob_name)
                download_blob(blob_service_client, container_name, blob_name, destination_path)
                print(f"Downloaded: {blob_name} to {destination_path}")

        # Introduce a delay before checking for new files again
        time.sleep(60)  # Sleep for 60 seconds (adjust as needed)

if __name__ == "__main__":
    main()
