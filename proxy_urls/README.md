## About script
this script take urls_file.txt then pass this urls to any proxy determined <br>

### Suggest some uses
sometimes we want use burpsuite scanner automaticly without browser the site <br>
1- open burpsuite and put the primary domain in scope then enable scan with option suite scope <br>
2- run this tool and take urls_file.txt , now burp suite scan any url from this file <br>
NOTIC: if dont have urls you can get from web-archive site or crawlling the site using any tool ex.. hakrawler

## Installation
```console
sudo apt install subversion
svn checkout https://github.com/Abdulrahman-Kamel/mini-hacks/trunk/proxy_urls
pip3 install -r requirements.txt
```

## Usage
short arg     | long arg      | Description
------------- | ------------- |-------------
-u            | --urls        | File contains urls
-t            | --threads     | Thread number to MultiProccess [speed tool] , Default 30
-s            | --sleep       | sleep after send every request
-d            | --display     | display request sended url
-h            | --help        | show the help message and exit

## Examples usage
python3 proxy_urls.py -u urls_file.txt -t 10 -s 600
