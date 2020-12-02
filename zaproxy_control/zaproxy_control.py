
# pip3 install python-owasp-zap-v2.4,time,pprint,os-sys
# usage: python3 zaproxy_control.py --urls http.txt --crawl -o spider_urls.txt
#		 python3 zaproxy_control.py --urls spider_urls.txt --scan --report scan_zaproxy.html

import argparse
import time
from pprint import pprint
from zapv2 import ZAPv2
import os

#======================= Start Arguments ====================
parser_arg_menu = argparse.ArgumentParser(prog='tool', formatter_class=lambda prog: argparse.HelpFormatter(prog, max_help_position=40)
)
parser_arg_menu.add_argument(
"-u" , "--urls" , help="File contain urls Ex: urls.txt",
metavar=""
)
parser_arg_menu.add_argument(
"-c" , "--crawl" , help="crawlling [spider] the urls",
action="store_true"
)
parser_arg_menu.add_argument(
"-sc" , "--scan" , help="scan the urls",
action="store_true"
)
parser_arg_menu.add_argument(
"-k" , "--apikey" , help="enter new api key zaproxy",
metavar=""
)
parser_arg_menu.add_argument(
"-o", "--output" ,help="Output results in file", 
metavar=""
)
parser_arg_menu.add_argument(
"-r", "--report" ,help="Output scaning report file", 
metavar=""
)

arg_menu = parser_arg_menu.parse_args()
#======================= End Arguments ====================

# configration
apikey = 'cbtdau706shilun9kp2gc41246'
zap = ZAPv2(apikey=apikey, proxies={'http': 'http://127.0.0.1:8090', 'https': 'http://127.0.0.1:8090'})
APIKEY = apikey if not arg_menu.apikey else str(arg_menu.apikey)

#Put Files in Mode
if arg_menu.urls:
	urlsOpen = open(arg_menu.urls , 'r')

if arg_menu.output:
	output = open(arg_menu.output , 'a+')


h = '\035[90m'	 # Header
b = '\033[96m'   # Blue
g = '\033[92m'	 # Green
y = '\033[93m'	 # Yellow
r = '\033[91m'	 # Red
e = '\033[0m'	 # End
B = '\033[1m' 	 # Bold
u = '\033[4m' 	 # underLine
n = '\033[5;91m' # notic



#======================= Start Functions  =====================

def crawl(urls):
	for url in urls:
		url = url.strip()
		# The scan returns a scan id to support concurrent scanning
		spider_url = zap.spider.scan(url)
		while int(zap.spider.status(spider_url)) < 100:
		    # Poll the status until it completes
		    print(g+'Spider progress ['+url+']: '+e+r+'%{}'.format(zap.spider.status(spider_url))+e)
		    time.sleep(2)
		    
		# Prints the URLs the spider has crawled
		print('\n'.join(map(str, zap.spider.results(spider_url))))
		if arg_menu.output:
		    output.writelines('start write \n')
		    output.writelines('\n'.join(map(str, zap.spider.results(spider_url))))




#======================= End Functions  =====================
	
if arg_menu.urls:
	if arg_menu.crawl:
		crawl(urlsOpen)
	
	elif arg_menu.scan:

		try:
			os.remove('scaningZaproxy.html')
		except:
			pass
		
		#passive Scan
		while int(zap.pscan.records_to_scan) > 0:
	   		time.sleep(1)

		#Active Scan	
		for url in urlsOpen:
			url = url.strip()
			scanid = zap.ascan.scan(url)

		while int(zap.ascan.status(scanid)) < 100:

			# Loop until the scanner has finished
			print('Scan progress ['+g +url+e+']:'+r+'%{}'.format(zap.ascan.status(scanid)) + e)
			time.sleep(1)


		if arg_menu.report:
			os.system('wget -O '+arg_menu.report+' http://localhost:8090/OTHER/core/other/htmlreport/?apikey='+APIKEY)

	else:
		print("Please Specified Action")

else:
	print("Invalid Arguments Please Look on --help")
