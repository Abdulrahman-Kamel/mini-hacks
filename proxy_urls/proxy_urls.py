# usage: python3 proxy_urls.py --urls http.txt -t 5 -s 20 -d

proxiess = {"http": "http://127.0.0.1:8080", 
			"https": "http://127.0.0.1:8080"}

import time
import requests
import urllib3 
import argparse
from concurrent.futures import ThreadPoolExecutor as PoolExecutor
from sys import exit


#======================= Start Arguments ====================
# arguments
parser_arg_menu = argparse.ArgumentParser(prog='tool', formatter_class=lambda prog: argparse.HelpFormatter(prog, max_help_position=40)
)
parser_arg_menu.add_argument(
"-u" , "--urls" , help="File contain urls Ex: urls.txt",
metavar=""
)
parser_arg_menu.add_argument(
"-t", "--threads" , help="Thread number to MultiProccess [speed tool] , Default 30",
metavar=""
)
parser_arg_menu.add_argument(
"-s", "--sleep" , help="sleep after every request",
metavar=""
)
parser_arg_menu.add_argument(
"-d", "--display" , help="display request sended",
action="store_true"
)

arg_menu    = parser_arg_menu.parse_args()
max_threads = int(arg_menu.threads) if arg_menu.threads else int(30)
max_sleep= int(arg_menu.sleep) if arg_menu.sleep else int(0.00000000000001)
#======================= End Arguments  =====================

class color:
    header = '\035[90m'
    blue = '\033[96m'
    green = '\033[92m'
    yellow = '\033[93m'
    red = '\033[91m'
    end = '\033[0m'
    bold = '\033[1m'
    underLine = '\033[4m'
    notic = '\033[5;91m'


urllib3.disable_warnings()


def run(single_url):
    try:
        request = requests.get(single_url, proxies=proxiess)
        if arg_menu.display:
            print(color.green + 'send: '+ request.url + color.end)
        time.sleep(max_sleep)


    except Exception as er:
        pass


if __name__ == "__main__":

    if not arg_menu.urls:
        print("-urls needed")
        exit(1)


    with open(arg_menu.urls, 'r') as f:
        urls_list = [line.rstrip() for line in f]

    with PoolExecutor(max_workers=max_threads) as executor:
        for _ in executor.map(run, urls_list):
            pass
