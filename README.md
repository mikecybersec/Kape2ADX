# Kape2ADX
This is a project for automating your KAPE process. Currently, this project takes KAPE .zips found in blob storage, turns the artefacts into super timelines, then uploads the .csv back to Blob. You can optionally connect blob as a data source to Azure Data Explorer to then do forensics via KQL.

## Prerequisites

- Virtual Machine to run your python script. (You can go one step further and host this in Azure if you'd like this to be event driven).
- Docker installed with 'log2timeline/plaso' image ready to go.

```apt install python3 python3-pip unzip inotify-tools -y```<br>
```pip install azure-storage-blob```<br>




