# Kape2ADX
This is a project for automating your KAPE process. Currently, this project takes KAPE .zips found in blob storage, turns the artefacts into super timelines, then uploads the .csv back to Blob. You can optionally connect blob as a data source to Azure Data Explorer to then do forensics via KQL.

## Prerequisites

apt install python3 python3-pip unzip inotify-tools -y
pip install azure-storage-blob



