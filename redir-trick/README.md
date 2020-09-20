## About script
this tool test open redirect vulnerability to each http subdomain via signs EX.. [/, @, etc..] 

use any tool to know what is subdomains which run http/https EX.. httprobe or any Tec.

cat subdomains | httprobe > https.txt | use tool on this file [https.txt]

the tool will put the sign and request all urls , when found redirect will alert you.

## Installation
i am make code to auto install modules only must have modules [importlib, pip] then tool will install all modules automatically but if found any error you can install all modules manually
```console
git clone --depth 1 https://github.com/Abdulrahman-Kamel/mini-sec-tasks.git redir-trick
pip3 install importlib pip
```
 if append modules install error use: pip3 install -r requments.txt

or usage manually
```bash
pip3 install requests
pip3 install argparse
pip3 install urllib3
pip3 install futures
pip3 install sys
```
## Usage
short arg     | long arg      | Description
------------- | ------------- |-------------
-u            | --urls        | File contain urls
-s            | --sign        | Determine one or multiple signs which put every url [Default = //]
-r            | --redirect    | Determine domain/ip which will redirect [Default = bing.com]
-t            | --threads     | Threads number to multiProccess [Default = 100]
-T            | --timeout     | Time out waiting if delay request , [Default 3]
-o            | --output      | Save the results to text file
-h            | --help        | show the help message and exit

if you want use multiple signs usage -s, --sign /,@,//  ==> seperator via [,]

## Examples
- Default usage
```python
python3 redir_trick.py --urls https.txt
```
- Put multiple signs  
```python
python3 redir_trick.py --urls https.txt --sign @,/
```
- Determine redirect domain/ip
```python
python3 redir_trick.py --urls https.txt --redirect google.com
```
- Determine threads and timeout
```python
python3 redir_trick.py --urls https.txt --threads 200 --timeout 10
```
