## About script
After you enumeration subdomains via tools example amass,sublist3r,etc.. you will found many subdomains not working , just old subdomains <br> 
This mini script will check ip/domain resolve or no [appending on ping command] , important use before run nmap scanner or -Pn argument in nmap tool or many scanner tool  <br>
Take hosts.txt file ,, return which resolve/runing , take 3 argument (hosts.txt=Required, output.txt=Required, threads=Optional)

## Install
```console
git clone --depth 1 https://github.com/Abdulrahman-Kamel/mini-hacks.git check-runing
pip3 install subprocess futures
```

## Usage
```python
python3 tool.py subdomains_or_ip.txt results.txt 500
```
