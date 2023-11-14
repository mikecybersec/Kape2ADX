# Kape2ADX
This is a project for automating your KAPE process. The project performs the following steps:
- Monitors Azure Blob container for new KAPE .zips
- Automatically pulls them down for processing with Log2Timeline/PSort (Auto checks for .zips already processed)
- Uploads the .csv super timeline to Blob container

The outputted super timelines can be ingested in Azure Data Explorer where you can then do DFIR with KQL. Some KQL queries have been provided under folder 'KQL'.

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




