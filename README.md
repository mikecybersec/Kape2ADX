# Kape2ADX
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

## Project Introduction
This is a project for automating your KAPE process. The project performs the following steps:
- Continously monitors Azure Blob container for new KAPE .zips landing
- Automatically pulls them down for processing with Log2Timeline/PSort (Auto checks for .zips already processed)
- Log files of each run is outputted to /opt/
- Uploads the .csv super timeline to Blob container
- You can then import this super timeline to Azure Data Explorer and run the provided KQL queries to expedite your forensics triage

![alt text](https://i.imgur.com/BiSSO7m.png)


## Technologies
![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)


## Inspiration & Acknowledgement
I'd like to acknowledge and thank the following for contributing either knowledge or inspiring me to create this:

- @Reconinfosec - https://github.com/ReconInfoSec/velociraptor-to-timesketch - This project is very similar, however, doesn't use the tech I'm used to using! Awesome project that inspired this.
- https://www.linkedin.com/in/sebh24/ - Providing advice around packaging up .py scripts for a later version.

## Getting Started

### 1. Setup Virtual Machine
- Virtual Machine to run the project (Ubuntu server 20.04) - I've tested this project on 8 vCPUs and 16GB RAM with 4-6 KAPE collections simultaneously, this takes about 2-2.5hrs to run.
- Azure storage account and container

### 2. Install prerequisites on VM
- ```sudo apt-get update```<br>
- ```sudo add-apt-repository ppa:gift/stable```<br>
- ```sudo apt-get update```<br>
- ```sudo apt-get install plaso-tools```<br>
- ```apt install python3 python3-pip unzip inotify-tools -y```<br>
- ```pip install azure-storage-blob```<br>
- ```snap install azcli```<br>
- ```git clone https://github.com/mikecybersec/Kape2ADX```
- ```chmod 777 processor.sh```

### 3. Edit variables in the scripts & Create 'Triage' directory
- You will need to provide 'watchblob.py' script with the following variables: Azure account name, Azure account key, Container name. You can find these by using CTRL + F "HERE" and replacing the placeholders.
- mkdir '/opt/kapetriages/'
- Edit the azdir variable for the install location of azcopy, in the processor.sh script

### 4. Run the project!
To run the project, run these in the following order:
- ```./processor.sh```
- ```sudo python3 watchblob.py```

## Features to add
- Ability to work with passworded .zip triages.
- Secure variables rather than storing them in code.
- I'm aiming to make the setup steps more slick, perhaps VM templates for Azure with pre-reqs already installed etc? Open to suggestions on how to better package this up :) 
  
## Disclaimer
This is a personal project, I recommend you take this project, test it and amend it to suit your requirements. I hold no responsibility for any adverse affects on data or infrastructure as a result of running this project.

## Feedback
Always welcome! I'm on X @mikecybersec


