import socket
import argparse
from concurrent.futures import ThreadPoolExecutor as PoolExecutor
from sys import exit

# arguments
parser_arg_menu = argparse.ArgumentParser(prog='tool', formatter_class=lambda prog: argparse.HelpFormatter(prog, max_help_position=40)
)
parser_arg_menu.add_argument(
"-s" , "--subdomains" , help="File contain urls Ex: urls.txt",
metavar=""
)
parser_arg_menu.add_argument(
"-p", "--ip" , help="ip only",
action="store_true"
)
parser_arg_menu.add_argument(
"-t", "--threads" , help="Thread number to MultiProccess [speed tool] , Default 30",
metavar=""
)
parser_arg_menu.add_argument(
"-o", "--output" ,help="Output results in file", 
metavar=""
)

arg_menu = parser_arg_menu.parse_args()
max_threads = int(arg_menu.threads) if arg_menu.threads else int(900)

sub_file 	= arg_menu.subdomains
output_file = arg_menu.output


def run(host):

	host = host.strip()

	try:
		ip = socket.gethostbyname(host)

		if not output_file:
			if arg_menu.ip:
				print(ip)
			else:
				print(host + ' ' + ip)


		if output_file: # IF Found Argument -o Put Result in File
			a_file = open(output_file,'a+')
			if arg_menu.ip:
				a_file.writelines(ip+'\n') # Writting In File
			else:
				a_file.writelines(host + ' ' + ip+'\n') # Writting In File

	except:  
		pass		



if __name__ == "__main__":
    if not arg_menu.subdomains:
        print("-s, --subdomains needed")
        exit(1)

# 2 line to make file lines to single line
with open(sub_file, 'r') as f:
    lines = [line.rstrip() for line in f]


# run tool via multiprocces
with PoolExecutor(max_threads) as executor:
    for _ in executor.map(run, lines):
        pass
