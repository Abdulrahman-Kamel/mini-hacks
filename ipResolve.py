import sys
import subprocess
from concurrent.futures import ThreadPoolExecutor as PoolExecutor

##############################
# Developer: Abdulrahman-Kamel
################################################################################
# This mini script to check if this ip resolve or no [appending on ping command]
# Important use before run nmap scanner and ETC..
# 
# Usage!
# 		 - Take ips.txt file ,, return which resolve/runing
#		 - python3 tool.py ips.txt results.txt
###########################################################



ips    = sys.argv[1]
output = sys.argv[2]

def tool(ip):

	try:
		res = subprocess.call(['ping', '-c', '1', ip])

		if res == 0:
			results = open(output,'a+').writelines(ip+'\n')
		elif res == 2:
			print("no response from", address)
		else:
			print("ping to", address, "failed!")

	except:
		pass



with open('ip.txt', 'r') as f:
	ip = [line.rstrip() for line in open(ips,'r')]

with PoolExecutor(int(1000)) as executor:
    #0xbahaa: we should give the "Map()" function two arguments:
    #  1- function name (or function ptr) to the function that checks a SINGLE link
    #  2- list of paramters (urls list)
	for _ in executor.map(tool, ip):
		pass
