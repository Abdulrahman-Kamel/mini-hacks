## About script
this script taken subdomains.txt file then give you subdomain with ip , can use {-p, --ip} to only results [ip] <br> 

## Installation
```console
sudo apt install subversion
svn checkout https://github.com/Abdulrahman-Kamel/mini-hacks/trunk/iphost
pip3 install -r requirements.txt
```

## Usage
short arg     | long arg      | Description
------------- | ------------- |-------------
-s            | --subdomains  | File contains subdomains
-p            | --ip          | result ip only
-t            | --threads     | Thread number to MultiProccess [speed tool] , Default 500
-o            | --output      | save results in file
-h            | --help        | show the help message and exit

## Examples usage
python3 iphost.py -s subs_file.txt -p -o results.txt
