# Kape2ADX
This is a project for automating your KAPE process. Currently, this project takes KAPE .zips found in blob storage, turns the artefacts into super timelines, then uploads the .csv back to Blob. You can optionally connect blob as a data source to Azure Data Explorer to then do forensics via KQL.

![alt text](https://i.imgur.com/BiSSO7m.png)


## Getting Started

### Setup Virtual Machine
- Virtual Machine to run the project (Ubuntu server 20.04)
- Azure storage account and container

### Install prerequisites on VM
- ```apt install python3 python3-pip unzip inotify-tools -y```<br>
- ```pip install azure-storage-blob```<br>
- ```wget "https://aka.ms/downloadazcopy-v10-linux" && tar -xvf downloadazcopy-v10-linux && rm downloadazcopy-v10-linux```<br>
- ```git clone urlhere```
- ```chmod 777 processor.sh```

### Run the project!
To run the project, run these in the following order:
- ```./processor.sh```
- ```python3 watch.py```




