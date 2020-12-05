## About script
this script to simple terminal usage zaproxy to {crawlling and scan} <br>
taken urls or subdomains file , then make this choose <br>
crawlling , active scan , passive scan , output the vulnerabilities in nice report <br><br>
NOTIC: zaproxy is very good to crawlling websites , i advice you use zaproxy to crawlling and enable active scan by argument to fast get vulnerabilities 

## Installation
```console
sudo apt install subversion
svn checkout https://github.com/Abdulrahman-Kamel/mini-hacks/trunk/zaproxy_control
pip3 install -r requirements.txt
```

## Usage
short arg     | long arg      | Description
------------- | ------------- |-------------
-u            | --urls        | File contain urls Ex: urls.txt
-c            | --crawl       | crawlling [spider] the urls
-sc           | --scan        | scan the urls
-k            | --apikey      | enter new api key zaproxy
-r            | --report      | Output scaning report file
-o            | --output      | Output crawlled urls in file
-h            | --help        | show the help message and exit

## Examples usage
python3 zaproxy_control.py -u subs_or_urls_file.txt -c --sc -r vulnerabilities.html -o crawlled_urls.txt
