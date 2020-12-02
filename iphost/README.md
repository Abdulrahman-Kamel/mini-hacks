## About script
this script taken subdomains.txt file then give you subdomain: ip , can use -p, --ip to only results [ip] <br> 

## Installation
pip3 install -r requirements.txt

## Usage
short arg     | long arg      | Description
------------- | ------------- |-------------
-s            | --subdomains  | File contains subdomains
-p            | --ip          | result ip only
-c            | --creds    	  | File contain http auth creds
-p            | --proxies     | File contains proxy:port
-t            | --threads     | Thread number to MultiProccess [speed tool] , Default 500
-o            | --output      | save results in file
-h            | --help        | show the help message and exit
