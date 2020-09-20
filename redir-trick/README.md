## About script
this tool test open redirect vulnerability to each http subdomain via signs EX.. [/, @, etc..]
use any tool to know what is subdomains which run http/https EX.. httprobe or any Tec
cat subdomains | httprobe > https.txt | use tool on this file [https.txt]

## Installation
i am make code to auto install modules must have only modules [importlib, pip] then tool will install all modules automatically  but if found any error you can install all modules manually
```
git clone --depth 1 https://github.com/Abdulrahman-Kamel/mini-sec-tasks.git redir-trick
pip3 install importlib pip
```
All modules
```
pip3 install requests
pip3 install argparse
pip3 install urllib3
pip3 install futures
pip3 install sys
```
## Examples
python3 redir_trick.py --urls https.txt : Default usage:
python3 redir_trick.py --urls https.txt --sign @,/ : multiple signs
python3 redir_trick.py --urls https.txt --redirect google.com : determine redirect domain/ip
python3 redir_trick.py --urls https.txt --threads 300 --timeout 10 : determine threads and timeout

| Command | Description |
| --- | --- |
| git status | List all new or modified files |
| git diff | Show file differences that haven't been staged |
