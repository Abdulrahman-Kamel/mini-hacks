#!/usr/bin/env python
# By Abdulrahman Kamel

import importlib # to check modules
import pip 		 # to install modules

# func to check and install modules
def install(package):
	spam_spec   = importlib.util.find_spec(package)
	check_found = spam_spec is not None

	if check_found == False:
		pip.main(['install', package])

install('requests')   # instead of pip3 install requests
install('argparse')   # instead of pip3 install argparse
install('urllib3') 	  # instead of pip3 install urllib3
install('futures')	  # instead of pip3 install futures
install('sys') 		  # instead of pip3 install sys


import requests
import argparse
import urllib3 
from concurrent.futures import ThreadPoolExecutor as PoolExecutor
from sys import exit

# set arguments
parser_arg_menu = argparse.ArgumentParser(epilog='Example: python3 redir_tricks.py --urls https.txt ',prog='tool', formatter_class=lambda prog: argparse.HelpFormatter(prog, max_help_position=15))
parser_arg_menu.add_argument(
"-u" , "--urls" , help="File contain urls",
metavar=""
)
parser_arg_menu.add_argument(
"-s" , "--sign" , help="Determine one or multiple sign which put every url [Default = //]",
metavar=""
)
parser_arg_menu.add_argument(
"-r" , "--redirect" , help="Determine domain/ip which will redirect [Default = bing.com] ",
metavar=""
)
parser_arg_menu.add_argument(
"-t", "--threads" , help="Threads number to multiProccess [Default = 100]",
metavar=""
)
parser_arg_menu.add_argument(
"-T", "--timeout" , help="Time out waiting if delay request , [Default 3]",
metavar=""
)
parser_arg_menu.add_argument(
"-o", "--output" ,help="Output results file", 
metavar=""
)

# refrences variables
arg_menu = parser_arg_menu.parse_args()
max_threads = int(arg_menu.threads) if arg_menu.threads  else int(100)
max_timeout = int(arg_menu.timeout) if arg_menu.timeout  else int(3)
redirect_to = arg_menu.redirect 	if arg_menu.redirect else "bing.com" 

# colors
h = '\035[90m'	 # Header
b = '\033[96m'   # Blue
g = '\033[92m'	 # Green
y = '\033[93m'	 # Yellow
r = '\033[91m'	 # Red
e = '\033[0m'	 # End
B = '\033[1m' 	 # Bold
u = '\033[4m' 	 # underLine
n = '\033[5;91m' # notic

# skeap ssl error 
urllib3.disable_warnings()

# check on missing argument
if not arg_menu.urls:
	print('missing argument: -u, --urls'); exit(1)

# filter sign argument
if arg_menu.sign:
	signs = arg_menu.sign.split(',') if ',' in arg_menu.sign else arg_menu.sign

else:
	signs = "/"


# func to write in output file
def write(value):
	global output
	output = open(arg_menu.output,'a+')
	output.writelines(value)

# func to write message
def msg(msg,URL,STATUS,HEADER):
	message1 = r + URL + e + ' [' + str(STATUS) + ']\nRedirect to: ' + b + HEADER + e + '\n\n'
	message2 = URL + ' [' + str(STATUS) + ']\nRedirect to: ' + HEADER + '\n\n'

	if msg == 1:
		print(message1)
	elif msg ==2:
		print(message2)

# func primary tool
def tool(url):

	# if one sign
	if type(signs) is not list:
		sign = signs
		
		try:
			response = requests.get(url + sign + redirect_to , verify=False, allow_redirects=False, timeout=max_timeout)

			if response.headers['Location']:
				msg(1,response.url,response.status_code,response.headers['Location'])

				if arg_menu.output:
					write(msg(2,response.url,response.status_code,response.headers['Location']))

		except Exception as er:
			pass

	# if multiple signs
	if type(signs) is list:
		
		try:
			for single_sign in signs:
				response = requests.get(url + single_sign + redirect_to , verify=False, allow_redirects=False, timeout=max_timeout)

				if response.headers['Location']:
					msg(1,response.url,response.status_code,response.headers['Location'])

					if arg_menu.output:
						write(msg(2,response.url,response.status_code,response.headers['Location']))

		except Exception as er:
			pass


# make single url from file
with open(arg_menu.urls, 'r') as f:
    single_url = [line.rstrip() for line in f]

# run tool via multipleProccess
with PoolExecutor(max_threads) as executor:
    for _ in executor.map(tool, single_url):
       pass

# close file
if arg_menu.output:
	output.close()
