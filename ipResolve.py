import sys
import subprocess
from concurrent.futures import ThreadPoolExecutor as PoolExecutor

##############################
# Developer: Abdulrahman-Kamel
################################################################################
# This mini script to check if this ip resolve or no [appending on ping command]
# Important use before run nmap scanner and ETC..
# Take hosts.txt file ,, return which resolve/runing
#
#
# Usage!
# 	   - take 3 argument (hosts.txt=Required, output.txt=Required, threads=Optional)
#	   - python3 tool.py subdomains_or_ip.txt results.txt 500
####################################################################################

if len(sys.argv) < 2:
	print('Missing ips file [First argument]'); exit(1)

if len(sys.argv) < 3:
	print('Missing output file [Secound argument]'); exit(1)

ips     = sys.argv[1]
output  = sys.argv[2]
threads = int(sys.argv[3]) if len(sys.argv) > 3 else int(200)


def tool(ip):
	
	try:
		res = subprocess.call(['ping', '-c', '1', ip])
		if res == 0:
			results = open(output,'a+').writelines(ip+'\n')
			
	except:
		pass


with open(ips, 'r') as f:
	ip = [line.rstrip() for line in open(ips,'r')]

with PoolExecutor(threads) as executor:
	for _ in executor.map(tool, ip):
		pass

if ips:
	open(ips,'r').close()

if output:
	open(output,'a+').close()
