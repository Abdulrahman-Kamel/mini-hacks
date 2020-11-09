#!/bin/bash
: '
# usage
install:  chmod +x recon.sh
		  ./recon --install

Run: ./recon domain.com {low , medium , hard}
Run: ./recon domain.com {functions} ex..
./recon.sh domain.com --subdomains --takeovers --portscan --screenshot --archive --gfparams --meg --gfscan --gobuster --nuclie --report
 --awsMisc

'

github_apiKEY="717971c136190f44d3551f6f17daf7cc141fb39e"

: 'Set the main variables'

domain="$1"
VERSION="1.3"

companyName=$(echo -n $domain | cut -d '.' -f 1) # Get target name 

# colors 
RED="\033[0;31m"
BLUE="\033[0;34m"
YELLOW="\033[1;33m"
GREEN="\033[0;32m"
RESET="\033[0m"
NOTIC="\e[5m"
NOTIC_RESET="\e[25m"


# paths
TOOLS="$HOME/bughunter/tools"
recon="$TOOLS/recon"
SCRIPTS="$recon/scripts"
RESULTDIR="$HOME/bughunter/projects/$domain"
RECONDIR="$HOME/bughunter/projects/$domain/recon"
SCANDIR="$HOME/bughunter/projects/$domain/scan"

WORDLIST="$RECONDIR/wordlists"
gobuster_wordlist="$recon/wordlists/fuzz.txt"

SCREENSHOTS="$RECONDIR/screenshots"
SUBS="$RECONDIR/subdomains"
URLS="$RECONDIR/urls"
DIRSCAN="$RECONDIR/directories"
HTML="$RECONDIR/html"
GFSCAN="$SCANDIR/gfscan"
IPS="$RECONDIR/ips"
PORTSCAN="$SCANDIR/portscan"
ARCHIVE="$RECONDIR/archive"
GF_PARAM_DIR="$RECONDIR/gf_params"
ERROR="$recon/logs/error_commands.txt"
NUCLEISCAN="$SCANDIR/nucleiscan"


: 'write report'
html_report() {
	echo "<!DOCTYPE html>
	<html>
	<head>
		<title>Report $targetName </title>
	</head>
	<style type="text/css">

		body{
		background-color: #ecf0f1;
	}


	iframe.style1{
	  transition: all.6s;
	  display: block;
	  height: 50px;
	  width: 50px;
	  border: 10px solid black;
	  border-radius: 40px;
	  margin: 1.5%;

	}

	iframe.style1:hover{
	  transition: all.9s;
	  border-radius: 20px;
	  width: 97%;
	  height: 600px;
	  box-shadow: inset -14px -13px 50px 0px, inset -14px -18px 18px -15px #03f1db87;
	  background-color: #0000000d;


	}

	iframe.show-all{

		width: 100%;
		height: 1200px;
	  	border: 5px solid black;
	  	border-radius: 20px;
		transition: none;
		margin-top: 10px;
	}

	.title-iframe{
	  font-family: Noto Sans, sans-serif; 
	  font-family: medium-content-serif-font, Georgia, Cambria, "Times New Roman", Times, serif;
	  xbox-shadow: inset -14px -13px 29px 0px, inset -14px -18px 18px -15px #03f1db87;
	  box-shadow: inset 1.2px -0.8px 0px 1px, inset 1.8px 1.8px 14px -14px #00000066;
	  font-style: italic;
	  letter-spacing: -0.004em;
	  letter-spacing: 0.4em;
	  word-break: break-word;
	  font-weight: bold;
	  font-size: 30px;
	  border-radius: 210px;
	  background-color: black;
	  color:#747b7b;
	  transition: 1.5s;

	}


	.mini_title{
			border-radius: 40px;
			box-shadow: black 1.2px -0.8px 0px -4px, inset 1.8px 1.8px 18px -8px black;
			padding: 5px;
	}
	
		
	h1{
		
		  font-family: Noto Sans, sans-serif; 
		  font-family: medium-content-serif-font, Georgia, Cambria, "Times New Roman", Times, serif;
		  xbox-shadow: inset -14px -13px 29px 0px, inset -14px -18px 80px -15px #03f1db87;
		  box-shadow: inset 1.2px -0.8px 0px 1px, inset 1.8px 1.8px 14px -14px #00000066;
		  font-style: italic;
		  letter-spacing: -0.004em;
		  letter-spacing: 0.4em;
		  word-break: break-word;
		  font-weight: bold;
		  font-size: 30px;
		  border-radius: 210px;
		  background-color: black;
		  color:#747b7b;
		  transition: 1.5s;
		  font-size: 40px;
		  padding: 15px;
		  margin-bottom: 80px;
		}



	h1:hover{
			 cursor: pointer;
		  box-shadow: inset -14px -13px 29px 0px, inset -14px -18px 18px -15px #03f1db87;

	}

	h2{
		color: #27ae60;
		padding: 10px;
		font-size: 30px;
		margin-bottom: 15px;
	}


	h3{
		color: #27ae60;
		border-style: dotted;
		font-size: 26px;
		padding: 8px;
	}

	h4{
		  font-family: Noto Sans, sans-serif; 
		  font-family: medium-content-serif-font, Georgia, Cambria, "Times New Roman", Times, serif;
		  xbox-shadow: inset -14px -13px 29px 0px, inset -14px -18px 18px -15px #03f1db87;
		  box-shadow: inset 1.2px -0.8px 0px 1px, inset 1.8px 1.8px 14px -14px #00000066;
		  font-style: italic;
		  letter-spacing: -0.004em;
		  letter-spacing: 0.4em;
		  word-break: break-word;
		  font-weight: bold;
		  border-radius: 210px;
		  background-color: black;
		  color:#747b7b;
		  transition: 1.5s;
		  font-size: 20px;
		  padding: 15px;
		  margin-bottom: 50px;
	}


	a{
		
		  font-family: Noto Sans, sans-serif; 
		  font-style: italic;
		  letter-spacing: -0.004em;
		  word-break: break-word;
		  font-weight: 800;
		  margin-left: 0;
		  margin-top: 0;
		  font-size:  21px;
		  color: #95a5a6;
		  display: block;
		  text-decoration: none;
		  border-radius: 40px;
		  padding: 3px;
		  width: 22%;
	}


	a:hover{
		border-radius: 40px;
		box-shadow: black 1.2px -0.8px 0px -4px, inset 1.8px 1.8px 18px -8px black;

	}
	
</style>

<body> 

	<h1 align="center">This Report To $domain </h1>
		
		<h4 width=>Network Part</h4>
			<a href="recon/ips/iphost.txt" target="_blank">IP - Subdomains</a><br><br>
			<a href="recon/ips/$domain-cidr.txt" target="_blank">IP Ranges</a><br><br>
			<a href="recon/ips/$domain-origin-ips.txt" target="_blank">Origin - ips</a><br><br>

		<h4>Recon</h4>
			<a href="recon/subdomains/alive_subdomains.txt" target="_blank">Alive - subdomains</a><br><br>
			<a href="recon/subdomains/subdomains_cname.txt" target="_blank">Cname - subdomains</a><br><br>
			<a href="recon/subdomains/root-subdomains.txt" target="_blank">Root - subdomains</a><br><br>
			<a href="recon/subdomains/hosts.txt" target="_blank">Alive - subdomains on http</a><br><br>
			<a href="recon/archive/js_endpoints.txt" target="_blank">JS endpoints</a><br><br>


			<a href="recon/screenshots/report.html" target="_blank">Screenshot[subs]</a><br><br>
			<a href="recon/directories/" target="_blank">Bruteforce [gobuster]</a><br><br>
			<a href="recon/gf_params/" target="_blank">gf [params]</a><br><br>
			<a href="recon/gf_params_2/" target="_blank">gf [params]_2</a><br><br>
			<a href="recon/subdomains/meg" target="_blank">meg</a><br><br>
			<a href="recon/urls/401_statusCode.txt" target="_blank">http 401</a>&nbsp;
			<a href="recon/urls/403_statusCode.txt" target="_blank">http 403</a>&nbsp;
			<a href="recon/urls/404_statusCode.txt" target="_blank">http 404</a><br><br>



		<h4>Scan</h4>	
			<a href="recon/subdomains/subjack.txt" target="_blank">subjack</a><br><br>
			<a href="recon/subdomains/takeovers.txt" target="_blank">takeovers</a><br><br>
			<a href="scan/aws_Misconfiguration/s3scanner.txt" target="_blank">AwsBucket</a><br><br>
			<a href="scan/gfscan/" target="_blank">gf [scan]</a><br><br>
			<a href="scan/nucleiscan/" target="_blank">nuclei scan</a><br><br>
			<a href="scan/httpAUTH_broken_authentication.txt" target="_blank">http_authe password</a><br><br>
			<a href="scan/portscan/" target="_blank">port scan</a><br><br>

		<h4>Root-Files</h4>
			<iframe class="style1" src="."></iframe>

		<h2 align="center" class="title-iframe">Archive</h2>  <br><br> 
				<a href="recon/archive/clean_urls.txt" target="_blank">All urls</a><br><br>
				<a href="recon/archive/param_list.txt" target="_blank">param list</a><br><br>
				<a href="recon/archive/paths_list.txt" target="_blank">paths list </a><br><br>
				<a href="recon/archive/param_with_value_list.txt" target="_blank">param with value list</a><br><br><br><br>

				<br>


<script>confirm('[$domain] report')</script>
</body>
</html>" > "$RESULTDIR"/index.html

}

: 'Display main info'
displayMainInfo() {
	clear
	echo -e "Developer via $RED Abdulrahman Kamel $RESET \n [$REDversion $VERSION $RESET]"
	}

	: 'Basic requirements'
	basicRequirements() {
		echo -e "[$GREEN+$RESET] This script will install the required dependencies to run recon.sh, please stand by.."
		echo -e "[$GREEN+$RESET] It will take a while, go grab a cup of coffee :)"
		cd "$HOME" || return
		sleep 1
		echo -e "[$GREEN+$RESET] Getting the basics.."
		export LANGUAGE=en_US.UTF-8
		export LANG=en_US.UTF-8
		export LC_ALL=en_US.UTF-8
		sudo apt-get update -y
		sudo apt-get install git -y
		#git clone https://github.com/x1mdev/recon.git
		sudo apt-get install -y --reinstall build-essential
		sudo apt install -y python3-pip
		sudo apt install -y file
		sudo apt-get install -y dnsutils
		sudo apt install -y lua5.1 alsa-utils libpq5
		sudo apt-get autoremove -y
		sudo apt clean
		sudo apt install parallel -y
		sudo apt install snap
		sudo apt install whois
		sudo apt install snapd
		#echo -e "[$GREEN+$RESET] Stopping Docker service.."
		#sudo systemctl disable docker.service
		#sudo systemctl disable docker.socket
		echo -e "[$GREEN+$RESET] Creating directories.."
		mkdir -p "$HOME"/bughunter
		mkdir -p "$HOME"/bughunter/tools
		mkdir -p "$HOME"/bughunter/projects
		mkdir -p "$HOME"/go
		mkdir -p "$HOME"/go/src
		mkdir -p "$HOME"/go/bin
		mkdir -p "$HOME"/go/pkg
		sudo chmod u+w .
		echo -e "[$GREEN+$RESET] Done."
	}

: 'Golang initials'
golangInstall() {
	echo -e "[$GREEN+$RESET] Installing and setting up Go.."

	if [[ $(go version | grep -o '1.14') == 1.14 ]]; then
		echo -e "[$GREEN+$RESET] Go is already installed, skipping installation"
	else
		cd "$HOME"/bughunter/tools || return
		git clone https://github.com/udhos/update-golang
		cd "$HOME"/bughunter/tools/update-golang || return
		sudo bash update-golang.sh
		sudo cp /usr/local/go/bin/go /usr/bin/ 
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Adding recon alias & Golang to "$HOME"/.bashrc.."
	sleep 1
	configfile="$HOME"/.bashrc

	if [ "$(cat "$configfile" | grep '^export GOPATH=')" == "" ]; then
		echo export GOPATH='$HOME'/go >>"$HOME"/.bashrc
	fi

	if [ "$(echo $PATH | grep $GOPATH)" == "" ]; then
		echo export PATH='$PATH:$GOPATH'/bin >>"$HOME"/.bashrc
	fi

	if [ "$(cat "$configfile" | grep '^alias recon=')" == "" ]; then
		echo "alias recon=$HOME/tools/automachine_recon/recon.sh" >>"$HOME"/.bashrc
	fi

	bash /etc/profile.d/golang_path.sh

	source "$HOME"/.bashrc

	cd "$HOME" || return
	echo -e "[$GREEN+$RESET] Golang has been configured."
}

: 'Golang tools'
golangTools() {
	if ! command -v subfinder &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing subfinder.."
		GO111MODULE=on go get -u -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] Subfinder already installed."
	fi

	if ! command -v subjack &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing subjack.."
		go get -u -v github.com/haccer/subjack
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] subjack already installed."
	fi

	if ! command -v aquatone &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing aquatone.."
		go get -u -v github.com/michenriksen/aquatone
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] aquatone already installed."
	fi

	if ! command -v httprobe &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing httprobe.."
		go get -u -v github.com/tomnomnom/httprobe
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] httprobe already installed."
	fi

	if ! command -v assetfinder &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing assetfinder.."
		go get -u -v github.com/tomnomnom/assetfinder
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] assetfinder already installed."
	fi

	if ! command -v waybackurls &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing waybackurls.."
		go get github.com/tomnomnom/waybackurls
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] waybackurls already installed."
	fi

	if ! command -v meg &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing meg.."
		go get -u -v github.com/tomnomnom/meg
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] meg already installed."
	fi


	if ! command -v tojson &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing tojson.."
		go get -u -v github.com/tomnomnom/hacks/tojson
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] tojson already installed."
	fi


	if ! command -v unfurl &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing unfurl.."
		go get -u -v github.com/tomnomnom/unfurl
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] unfurl already installed."
	fi


	if ! command -v gf &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing gf.."
		go get -u -v github.com/tomnomnom/gf
		go get -u github.com/tomnomnom/gf
		echo 'source $GOPATH/src/github.com/tomnomnom/gf/gf-completion.bash' >> ~/.bashrc
		cp -r $GOPATH/src/github.com/tomnomnom/gf/examples ~/.gf
		cd "$HOME"/bughunter/tools/ || return
		git clone https://github.com/1ndianl33t/Gf-Patterns
		mkdir -p "$HOME"/.gf
		cp -r "$HOME"/bughunter/tools/Gf-Patterns/*.json ~/.gf
		git clone https://github.com/dwisiswant0/gf-secrets
		cp "$HOME"/bughunter/tools/gf-secrets/.gf/*.json ~/.gf
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] gf already installed."
	fi


	if ! command -v anew &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing anew.."
		go get -u -v github.com/tomnomnom/anew
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] anew already installed."
	fi


	if ! command -v qsreplace &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing qsreplace.."
		go get -u -v github.com/tomnomnom/qsreplace
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] qsreplace already installed."
	fi


	if ! command -v ffuf &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing ffuf.."
		go get -u -v github.com/ffuf/ffuf
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] ffuf already installed."
	fi


	if ! command -v gobuster &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing gobuster.."
		go get -u -v github.com/OJ/gobuster
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] gobuster already installed."
	fi

	if ! command -v gobuster &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing urlive.."
		go get -u github.com/vsec7/urlive
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] urlive already installed."
	fi

	if ! command -v amass &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing amass.."
		sudo snap install amass
		GO111MODULE=on go get -v github.com/OWASP/Amass/v3/...
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] amass already installed."
	fi


	if ! command -v getJS &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing getJS.."
		go get -u -v github.com/003random/getJS
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] getJS already installed."
	fi


	if ! command -v gau &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing gau.."
		go get -u -v github.com/lc/gau
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] gau already installed."
	fi

	if ! command -v crobat &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing crobat.."
		go get -u github.com/cgboal/sonarsearch/crobat
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] crobat already installed."
	fi

	if ! command -v slackcat &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing assetfinder.."
		go get -u github.com/dwisiswant0/slackcat
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] slackcat already installed."
	fi

	if ! command -v github-subdomains &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing github-subdomains.."
		go get -u github.com/gwen001/github-subdomains
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] github-subdomains already installed."
	fi

	if ! command -v shuffledns &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing shuffledns.."
		GO111MODULE=on go get -u -v github.com/projectdiscovery/shuffledns/cmd/shuffledns
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] shuffledns already installed."
	fi


	if ! command -v dnsprobe &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing dnsprobe.."
		GO111MODULE=on go get -u -v github.com/projectdiscovery/dnsprobe
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] dnsprobe already installed."
	fi


	if ! command -v nuclei &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing nuclei.."
		GO111MODULE=on go get -u -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] nuclei already installed."
	fi

:' 
	if ! command -v sqlmap &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing sqlmap.."
		sudo snap install sqlmap
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] sqlmap already installed."
	fi
'

	if ! command -v cf-check &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing cf-check.."
		# go get -u github.com/dwisiswant0/cf-check
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] cf-check already installed."
	fi


	if ! command -v dalfox &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing dalfox.."
		GO111MODULE=on go get -u -v github.com/hahwul/dalfox
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] dalfox already installed."
	fi


	if ! command -v hakrawler &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing hakrawler.."
		go get -u -v github.com/hakluke/hakrawler
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] hakrawler already installed."
	fi


	if ! command -v naabu &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing naabu.."
		GO111MODULE=on go get -u -v github.com/projectdiscovery/naabu/v2/cmd/naabu
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] naabu already installed."
	fi


	if ! command -v chaos &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing chaos.."
		GO111MODULE=on go get -u github.com/projectdiscovery/chaos-client/cmd/chaos
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] chaos already installed."
	fi


	if ! command -v httpx &> /dev/null
	then
		echo -e "[$YELLOW$NOTIC+$RESET$NOTIC_RESET] Installing httpx.."
		GO111MODULE=auto go get -u -v github.com/projectdiscovery/httpx/cmd/httpx
		echo -e "[$GREEN+$RESET] Done."
	else
		echo -e "[$GREEN+$RESET] httpx already installed."
	fi
}

: 'Additional tools'
additionalTools() {
	echo -e "[$GREEN+$RESET] Installing massdns.."
	if [ -e /usr/local/bin/massdns ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/bughunter/tools/ || return
		git clone https://github.com/blechschmidt/massdns.git
		cd "$HOME"/bughunter/tools/massdns || return
		echo -e "[$GREEN+$RESET] Running make command for massdns.."
		make -j
		sudo cp "$HOME"/tools/massdns/bin/massdns /usr/local/bin/
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing nuclei-templates.."
	nuclei -update-templates
	echo -e "[$GREEN+$RESET] Done."

	echo -e "[$GREEN+$RESET] Installing jq.."
	sudo apt install -y jq
	echo -e "[$GREEN+$RESET] Done."

	echo -e "[$GREEN+$RESET] Installing Chromium browser.."
	sudo apt install -y chromium-browser
	echo -e "[$GREEN+$RESET] Done."

	echo -e "[$GREEN+$RESET] Installing masscan.."
	if [ -e /usr/local/bin/masscan ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/bughunter/tools/ || return
		git clone https://github.com/robertdavidgraham/masscan
		cd "$HOME"/bughunter/tools/masscan || return
		make -j
		sudo cp bin/masscan /usr/local/bin/masscan
		sudo apt install libpcap-dev -y
		cd "$HOME"/bughunter/tools/ || return
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing Corsy (CORS Misconfiguration Scanner).."
	if [ -e "$HOME"/tools/Corsy/corsy.py ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/bughunter/tools/ || return
		git clone https://github.com/s0md3v/Corsy.git
		cd "$HOME"/bughunter/tools/Corsy || return
		sudo pip3 install -r requirements.txt
		cd "$HOME"/bughunter/tools/ || return
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing dirsearch.."
	if [ -e "$HOME"/tools/dirsearch/dirsearch.py ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/bughunter/tools/ || return
		git clone https://github.com/maurosoria/dirsearch.git
		cd "$HOME"/bughunter/tools/ || return
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing Arjun (HTTP parameter discovery suite).."
	if [ -e "$HOME"/tools/Arjun/arjun.py ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/bughunter/tools/ || return
		git clone https://github.com/s0md3v/Arjun.git
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing Dnsgen .."
	if [ -e "$HOME"/tools/dnsgen/setup.py ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/bughunter/tools/ || return
		git clone https://github.com/ProjectAnte/dnsgen
		cd "$HOME"/bughunter/tools/dnsgen || return
		pip3 install -r requirements.txt --user
		sudo python3 setup.py install
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing sublert.."
	if [ -e "$HOME"/tools/sublert/sublert.py ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/bughunter/tools/ || return
		git clone https://github.com/yassineaboukir/sublert.git
		cd "$HOME"/bughunter/tools/sublert || return
		sudo apt-get install -y libpq-dev dnspython psycopg2 tld termcolor
		pip3 install -r requirements.txt --user
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing findomain.."
	arch=`uname -m`
	if [ -e "$HOME"/bughunter/tools/findomain ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	elif [[ "$arch" == "x86_64" ]]; then
		wget https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux -O "$HOME"/tools/findomain
		chmod +x "$HOME"/bughunter/tools/findomain
		sudo cp "$HOME"/bughunter/tools/findomain /usr/local/bin
		echo -e "[$GREEN+$RESET] Done."
	else
		wget https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-aarch64 -O "$HOME"/tools/findomain
		chmod +x "$HOME"/bughunter/tools/findomain
		sudo cp "$HOME"/bughunter/tools/findomain /usr/local/bin
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing LinkFinder.."
	# needs check
	if [ -e "$HOME"/bughunter/tools/LinkFinder/linkfinder.py ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/bughunter/tools/ || return
		git clone https://github.com/GerbenJavado/LinkFinder.git
		cd "$HOME"/bughunter/tools/LinkFinder || return
		pip3 install -r requirements.txt --user
		sudo python3 setup.py install
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing CertificateTransparencyLogs.."
	# needs check
	if [ -e "$HOME"/tools/CertificateTransparencyLogs/certsh.py ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/bughunter/tools/ || return
		git clone https://github.com/ghostlulzhacks/CertificateTransparencyLogs
		cd "$HOME"/bughunter/tools/CertificateTransparencyLogs || return
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing altdns.."
	# needs check
	if [ -e "$HOME"/bughunter/tools/altdns/setup.py ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/bughunter/tools/ || return
		git clone https://github.com/infosec-au/altdns.git
		cd "$HOME"/bughunter/tools/altdns
		sudo python setup.py install
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing s3scanner.."
	# needs check
	if [ -e "$HOME"/bughunter/tools/S3Scanner/setup.py ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/bughunter/tools/ || return
		git clone https://github.com/sa7mon/S3Scanner.git
		cd "$HOME"/bughunter/tools/S3Scanner
		sudo pip install -r requirements.txt
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing bass.."
	# needs check
	if [ -e "$HOME"/bughunter/tools/bass/bass.py ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/bughunter/tools/ || return
		git clone https://github.com/Abss0x7tbh/bass.git
		cd "$HOME"/bughunter/tools/bass || return
		sudo pip3 install tldextract
		pip3 install -r requirements.txt --user
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing interlace.."
	if [ -e /usr/local/bin/interlace ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/bughunter/tools/ || return
		git clone https://github.com/codingo/Interlace.git
		cd "$HOME"/bughunter/tools/Interlace || return
		sudo python3 setup.py install
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing nmap.."
		sudo apt-get install -y nmap
		wget https://raw.githubusercontent.com/vulnersCom/nmap-vulners/master/vulners.nse -O /usr/share/nmap/scripts/vulners.nse && nmap --script-updatedb
		echo -e "[$GREEN+$RESET] Done."

	echo -e "[$GREEN+$RESET] Installing SecLists.."
	if [ -e "$HOME"/bughunter/tools/Seclists/Discovery ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/bughunter/tools/ || return
		#git clone https://github.com/danielmiessler/SecLists.git
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing Altdns.."
	pip install py-altdns
	echo -e "[$GREEN+$RESET] Done."

	echo -e "[$GREEN+$RESET] Installing Eyewitness.."
	cd "$HOME"/bughunter/tools/ || return
	git clone https://github.com/FortyNorthSecurity/EyeWitness.git
	sudo bash "$HOME"/bughunter/tools/EyeWitness/Python/setup/setup.sh
	echo -e "[$GREEN+$RESET] Done."
}

: 'Dashboard setup'
setupDashboard() {
	echo -e "[$GREEN+$RESET] Installing Nginx.."
	sudo apt-get install -y nginx
	sudo nginx -t
	echo -e "[$GREEN+$RESET] Done."
}

: 'Finalize'
finalizeSetup() {
	echo -e "[$GREEN+$RESET] Finishing up.."
	displayMainInfo
	source "$HOME"/.bashrc || return
	echo -e "[$GREEN+$RESET] Installation script finished! "
}


: 'Execute the main functions
displayMainInfo
basicRequirements
golangInstall
golangTools
additionalTools
setupDashboard
finalizeSetup
'

: '© 2020 GitHub, Inc.
Terms
Privacy
Security
Status
Help
Contact GitHub
Pricing
API
Training
Blog
About
'


Test(){
	type=$1
	line=$2

	if [ "$type" = 'bin' ]
	then

		if ! command -v $line &> /dev/null
		then
		    echo -e "$RED$NOTIC[-]$NOTIC_RESET Tool not found $BLUE [$line] $RESET"
		    #echo "[-] Command not found [$line]" >> $ERROR
		else
		    echo -e "$GREEN$NOTIC[+]$NOTIC_RESET Tool found $BLUE $line $RESET"

		fi
	fi

	if [ "$type" = 'dir' ]
	then
		
		if [ ! -d $line ]
		then
			  echo -e "$RED$NOTIC[-]$NOTIC_RESET Directory not found $BLUE $line $RESET"
			  #echo "[-] Directory not found [$line]" >> $ERROR
		fi	
	fi	

	if [ "$type" = 'file' ]
	then
		
		if [ ! -f $line ]
		then
			  echo -e "$RED$NOTIC[-]$NOTIC_RESET File not found $BLUE $line $RESET"
			  #echo "[-] File not found [$line]" >> $ERROR
		fi	
	fi	
}


checkDirectories() {
		echo -e "[$GREEN+$RESET] Creating directories and grabbing wordlists for $GREEN$domain$RESET.."
		mkdir -p "$RESULTDIR"
		mkdir -p "$RECONDIR" "$SCANDIR" "$SUBS" "$SCREENSHOTS" "$DIRSCAN" "$HTML" "$WORDLIST" "$IPS" "$PORTSCAN" "$ARCHIVE" "$NUCLEISCAN" "$GFSCAN" "$GF_PARAM_DIR" "$URLS"
		mkdir -p "$SCANDIR"/aws_Misconfiguration "$GF_PARAM_DIR"/filtered
}

startFunction() {
	tool=$1
	echo -e "[$GREEN+$RESET] Starting $tool"
}

: 'Gather resolvers'
gatherResolvers() {
	startFunction "Get fresh working resolvers"
	wget https://raw.githubusercontent.com/janmasarik/resolvers/master/resolvers.txt -O "$IPS"/resolvers.txt
}

: 'subdomain gathering'
gatherSubdomains() {
	startFunction "sublert"
	echo -e "[$GREEN+$RESET] Checking for existing sublert output, otherwise add it."
	if [ ! -e "$SUBS"/sublert.txt ]; then
		cd "$HOME"/bughunter/tools/sublert || return
		yes | python3 sublert.py -u "$domain"
		cp "$HOME"/bughunter/tools/sublert/output/"$domain".txt "$SUBS"/sublert.txt
		cd "$HOME" || return
	else
		cp "$HOME"/bughunter/tools/sublert/output/"$domain".txt "$SUBS"/sublert.txt
	fi
	echo -e "[$GREEN+$RESET] Done, next."

	startFunction "subfinder"
	subfinder -d "$domain" -all -config $recon/configs/config.yaml -o "$SUBS"/subfinder.txt
	echo -e "[$GREEN+$RESET] Done, next."

	startFunction "assetfinder"
	assetfinder --subs-only "$domain" >"$SUBS"/assetfinder.txt
	echo -e "[$GREEN+$RESET] Done, next."

	startFunction "amass"
	#amass enum -passive -d "$domain" -config $recon/configs/config.ini -o "$SUBS"/amass.txt
	echo -e "[$GREEN+$RESET] Done, next."

	startFunction "findomain"
	findomain -t "$domain" -u "$SUBS"/findomain_subdomains.txt
	echo -e "[$GREEN+$RESET] Done, next."

	startFunction "chaos"
	chaos -d "$domain" -key $CHAOS_KEY -o "$SUBS"/chaos_data.txt
	echo -e "[$GREEN+$RESET] Done, next."

	startFunction "github-subdomains"
	github-subdomains -t "$github_apiKEY" -d "$domain" | sort -u >> "$SUBS"/github_subdomains.txt
	echo -e "[$GREEN+$RESET] Done, next."

	startFunction rapiddns
	crobat -s "$domain" | sort -u | tee "$SUBS"/rapiddns_subdomains.txt
	echo -e "[$GREEN+$RESET] Done, next."

	echo -e "[$GREEN+$RESET] Combining and sorting results.."
	cat "$SUBS"/*.txt | sort -u >"$SUBS"/subdomains
	echo -e "[$GREEN+$RESET] Resolving subdomains.."
	cat "$SUBS"/subdomains | sort -u | shuffledns -silent -d "$domain" -r "$IPS"/resolvers.txt > "$SUBS"/alive_subdomains.txt
	
	# Pull root subdomains
	cat "$SUBS"/alive_subdomains.txt | rev | cut -d . -f 1-3 | rev | sort -u > "$SUBS"/root-subdomains.txt	
	
	echo -e "[$GREEN+$RESET] Getting alive hosts.."
	cat "$SUBS"/alive_subdomains.txt | httprobe -prefer-https | tee "$SUBS"/tmp_hosts
	cat "$SUBS"/tmp_hosts | grep "$domain" > "$SUBS"/tmp2_hosts
	sed -r '/^\s*$/d' "$SUBS"/tmp2_hosts > "$SUBS"/hosts.txt
	rm "$SUBS"/tmp*

	echo -e "[$GREEN+$RESET] Done."
}


: 'subdomain takeover check'
checkTakeovers() {
	startFunction "subjack"
	subjack -w "$SUBS"/hosts.txt -a -ssl -t 50 -v -c "$recon"/configs/fingerprints.json -o "$SUBS"/subjack.txt -ssl
	grep -v "Not Vulnerable" <"$SUBS"/subjack.txt >"$SUBS"/takeovers.txt
	#rm "$SUBS"/all-takeover-checks.txt

	vulnto=$(cat "$SUBS"/takeovers.txt)
	if [[ $vulnto == *i* ]]; then
		echo -e "[$GREEN+$RESET] Possible subdomain takeovers:"
		for line in "$SUBS"/takeovers.txt; do
			echo -e "[$GREEN+$RESET] --> $vulnto "
		done
	else
		echo -e "[$GREEN+$RESET] No takeovers found."
	fi

	startFunction "nuclei to check takeover"
	cat "$SUBS"/hosts.txt | nuclei -t subdomain-takeover/ -c 50 -o "$SUBS"/nuclei-takeover-checks.txt
	vulnto=$(cat "$SUBS"/nuclei-takeover-checks.txt)
	if [[ $vulnto != "" ]]; then
		echo -e "[$GREEN+$RESET] Possible subdomain takeovers:"
		for line in "$SUBS"/nuclei-takeover-checks.txt; do
			echo -e "[$GREEN+$RESET] --> $vulnto "
		done
	else
		echo -e "[$GREEN+$RESET] No takeovers found."
	fi
}

: 'check aws Misconfiguration'
awsMisconfiguration() {
	startFunction "Check Aws Misconfiguration [s3scanner]"
	python3 "$TOOLS"/S3Scanner/s3scanner.py "$RECONDIR"/subdomains/alive_subdomains.txt -o "$SCANDIR"/aws_Misconfiguration/s3scanner.txt
	echo -e "[$GREEN+$RESET] Finished Aws Misconfiguration"
}

: 'Get all CNAME'
getCNAME() {
	startFunction "dnsprobe to get CNAMEs"
	cat "$SUBS"/subdomains.txt | dnsprobe -r CNAME -o "$SUBS"/subdomains_cname.txt
}

: 'Gather IPs with dnsprobe'
gatherIPs() {
	startFunction "Gather ips [iphost]" # iphost is faster
	python3 $recon/scripts/iphost.py -s "$SUBS"/alive_subdomains.txt -o "$IPS"/iphost.txt
	cat "$IPS"/iphost.txt | cut -d " " -f 2 | sort -u | tee "$IPS"/"$domain"-ips.txt
	bash "$recon"/scripts/cidr.sh $companyName "$IPS"/"$domain"-cidr.txt
	#cat "$SUBS"/subdomains.txt | dnsprobe -silent -f ip | sort -u | tee "$IPS"/"$domain"-ips.txt
	python3 $recon/scripts/clean_ips.py "$IPS"/"$domain"-ips.txt "$IPS"/"$domain"-origin-ips.txt 
	echo -e "[$GREEN+$RESET] Done."
}

: 'Portscan on found IP addresses'
portScan() {
	startFunction  "Port Scan"
	#cat "$SUBS"/alive_subdomains.txt | naabu -p - -silent -no-probe -exclude-cdn -nmap -config "$recon"/configs/naabu.conf
    #mv recon-nmap* "$PORTSCAN"
    sudo nmap -iL "$IPS"/"$domain"-ips.txt --top-ports 50000 -sV --script /usr/share/nmap/scripts/vulners.nse,http-title.nse --min-rate 40000 -T4 --max-retries 2 -oA "$SCANDIR"/portscan/$domain-nmap

	echo -e "[$GREEN+$RESET] Port Scan finished"
}

: 'Use eyewitness to gather screenshots'
gatherScreenshots() {
	startFunction "Screenshot Gathering"
# Bug in aquatone, once it gets fixed, will enable aquatone on x86 also.
	arch=`uname -m`
	if [[ "$arch" == "x86_64" ]]; then
        python3 $HOME/bughunter/tools/EyeWitness/Python/EyeWitness.py -f "$SUBS"/hosts.txt --no-prompt -d "$SCREENSHOTS"
    else
        aquatone -http-timeout 10000 -out "$SCREENSHOTS" <"$SUBS"/hosts.txt
    fi
	echo -e "[$GREEN+$RESET] Screenshot Gathering finished"
}




crawler() {
	startFunction "crawler"
	cat "$SUBS"/alive_subdomains.txt | hakrawler >> "$ARCHIVE"/getallurls.txt
	echo -e "[$GREEN+$RESET] crawler finished"
	: '
	cat "$http"/hakrawler.txt | sort -u | grep -P "\w+\.js(\?|$)" > "$http"/tmp_js.txt
	cat cat "$ARCHIVE"/getallurls.txt >> "$http"/tmp_js.txt
	cat "$http"/tmp_js.txt | sort -u > "$http"/js.txt
	
	rm "$http"/tmp_js.txt
	'
	# use zaproxy.py
}

#chmod +x "$recon"/scripts/delExt.sh
# replace "$ARCHIVE"/getallurls.txt to all_endpoints.txt after make crawlling
# edit startFunction func

fetchArchive() {
	startFunction "fetchArchive"

	cat "$SUBS"/hosts.txt | sed -e 's/https\?:\/\///' > "$SUBS"/hosts_without_protocol.txt 

	startFunction "run gau"
	cat "$SUBS"/hosts_without_protocol.txt | gau > "$ARCHIVE"/getallurls.txt

	startFunction "run unfurl"
	cat "$ARCHIVE"/getallurls.txt | sort -u | unfurl --unique keys 	   > "$ARCHIVE"/param_list.txt
	cat "$ARCHIVE"/getallurls.txt | sort -u | unfurl --unique paths    > "$ARCHIVE"/paths_list.txt
	cat "$ARCHIVE"/getallurls.txt | sort -u | unfurl --unique keypairs > "$ARCHIVE"/param_with_value_list.txt

	cat "$ARCHIVE"/getallurls.txt | qsreplace FFUF | sort -u > "$ARCHIVE"/param_ffuf.txt

	# cp  "$ARCHIVE"/getallurls.txt "$ARCHIVE"/clean_urls.txt
	# bash "$recon"/scripts/delExt.sh "$recon"/wordlists/negative-extentions.txt "$ARCHIVE"/clean_urls.txt

	cat "$ARCHIVE"/getallurls.txt | grep -v ."jpg\|jpeg\|gif\|css\|tif\|tiff\|png\|ttf\|woff\|woff2\|ico\|pdf\|svg\|txt\|js" > "$ARCHIVE"/clean_urls.txt
	cat "$SUBS"/hosts.txt >> "$ARCHIVE"/clean_urls.txt
	cat "$ARCHIVE"/getallurls.txt | sort -u | grep -P "\w+\.js(\?|$)"   | httpx -silent -status-code -mc 200 | awk '{print $1}' | sort -u > "$ARCHIVE"/js_urls.txt
	# cat "$ARCHIVE"/getallurls.txt | sort -u | grep -P "\w+\.php(\?|$)"  | httpx -silent -status-code -mc 200 | awk '{print $1}' | sort -u > "$ARCHIVE"/php_urls.txt
	# cat "$ARCHIVE"/getallurls.txt | sort -u | grep -P "\w+\.aspx(\?|$)" | httpx -silent -status-code -mc 200 | awk '{print $1}' | sort -u > "$ARCHIVE"/aspx_urls.txt
	cat "$ARCHIVE"/getallurls.txt | sort -u | grep -P "\w+\.jsp(\?|$)"  | httpx -silent -status-code -mc 200 | awk '{print $1}' | sort -u > "$ARCHIVE"/jsp_urls.txt
	echo -e "[$GREEN+$RESET] fetchArchive finished"
}


jsEndpoints() {
	startFunction "jsEndpoints"
	for js in $(cat "$ARCHIVE"/js_urls.txt); do
		python3 "$HOME"/bughunter/tools/LinkFinder/linkfinder.py -i $js -o cli | anew "$ARCHIVE"/js_endpoints.txt
	done
	echo -e "[$GREEN+$RESET] jsEndpoints finished"
}

: 'Use gf to find specifec params'
startGfGetParams() {
	startFunction "Checking for get determine params using gf"
	cat "$ARCHIVE"/clean_urls.txt | gf ssrf  			 > "$GF_PARAM_DIR"/ssrf.txt
	cat "$ARCHIVE"/clean_urls.txt | gf idor 		 	 > "$GF_PARAM_DIR"/idor.txt 
	cat "$ARCHIVE"/clean_urls.txt | gf debug_logic  	 > "$GF_PARAM_DIR"/debug_logic.txt 
	cat "$ARCHIVE"/clean_urls.txt | gf img-traversal  	 > "$GF_PARAM_DIR"/img-traversal.txt 
	cat "$ARCHIVE"/clean_urls.txt | gf interestingEXT  	 > "$GF_PARAM_DIR"/interestingEXT.txt 
	cat "$ARCHIVE"/clean_urls.txt | gf interestingparams > "$GF_PARAM_DIR"/interestingparams.txt 
	cat "$ARCHIVE"/clean_urls.txt | gf interestingsubs   > "$GF_PARAM_DIR"/interestingsubs.txt 
	#cat "$ARCHIVE"/clean_urls.txt | gf jsvar  			 > "$GF_PARAM_DIR"/jsvar.txt 
	cat "$ARCHIVE"/clean_urls.txt | gf lfi    			 > "$GF_PARAM_DIR"/lfi.txt 
	cat "$ARCHIVE"/clean_urls.txt | gf rce    			 > "$GF_PARAM_DIR"/rce.txt 
	cat "$ARCHIVE"/clean_urls.txt | gf redirect   		 > "$GF_PARAM_DIR"/redirect.txt 
	cat "$ARCHIVE"/clean_urls.txt | gf sqli   			 > "$GF_PARAM_DIR"/sqli.txt 
	cat "$ARCHIVE"/clean_urls.txt | gf ssti   			 > "$GF_PARAM_DIR"/ssti.txt 
	cat "$ARCHIVE"/clean_urls.txt | gf xss   			 > "$GF_PARAM_DIR"/xss.txt 

	# filtered the params
	cat "$GF_PARAM_DIR"/ssrf.txt  			  | qsreplace FFUF | sort -u > "$GF_PARAM_DIR"/filtered/ssrf.txt
	cat "$GF_PARAM_DIR"/idor.txt  			  | qsreplace FFUF | sort -u > "$GF_PARAM_DIR"/filtered/idor.txt
	cat "$GF_PARAM_DIR"/debug_logic.txt  	  | qsreplace FFUF | sort -u > "$GF_PARAM_DIR"/filtered/debug_logic.txt
	cat "$GF_PARAM_DIR"/img-traversal.txt  	  | qsreplace FFUF | sort -u > "$GF_PARAM_DIR"/filtered/img-traversal.txt
	cat "$GF_PARAM_DIR"/interestingEXT.txt    | qsreplace FFUF | sort -u > "$GF_PARAM_DIR"/filtered/interestingEXT.txt
	cat "$GF_PARAM_DIR"/interestingparams.txt | qsreplace FFUF | sort -u > "$GF_PARAM_DIR"/filtered/interestingparams.txt
	#cat "$GF_PARAM_DIR"/jsvar.txt  			  | qsreplace FFUF | sort -u > "$GF_PARAM_DIR"/filtered/jsvar.txt
	cat "$GF_PARAM_DIR"/lfi.txt  			  | qsreplace FFUF | sort -u > "$GF_PARAM_DIR"/filtered/lfi.txt
	cat "$GF_PARAM_DIR"/rce.txt  			  | qsreplace FFUF | sort -u > "$GF_PARAM_DIR"/filtered/rce.txt
	cat "$GF_PARAM_DIR"/redirect.txt  	      | qsreplace FFUF | sort -u > "$GF_PARAM_DIR"/filtered/redirect.txt
	cat "$GF_PARAM_DIR"/sqli.txt  		      | qsreplace FFUF | sort -u > "$GF_PARAM_DIR"/filtered/sqli.txt
	cat "$GF_PARAM_DIR"/ssti.txt 			  | qsreplace FFUF | sort -u > "$GF_PARAM_DIR"/filtered/ssti.txt
	cat "$GF_PARAM_DIR"/xss.txt 			  | qsreplace FFUF | sort -u > "$GF_PARAM_DIR"/filtered/xss.txt

	echo -e "[$GREEN+$RESET] Checking for get determine params using gf finished"

}



: 'Gather information with meg'
startMeg() {
	startFunction "meg"
	cd "$SUBS" || return
	meg -d 1000 -v /
	mv out meg
	cd "$HOME" || return
	echo -e "[$GREEN+$RESET] meg finished"
}



: 'Use gf to find secrets in responses'
startGfScan() {
	startFunction "Checking for secrets using gf"
	cd "$SUBS"/meg || return
	for i in `gf -list`; do [[ ${i} =~ "_secrets"* ]] && gf ${i} >> "$GFSCAN"/"${i}".txt; done
	cd "$HOME" || return
	echo -e "[$GREEN+$RESET] Checking for secrets using gf finished"
}

: 'directory brute-force'
goBuster() {
	startFunction "Directory brute-force"
	# maybe run with interlace? Might remove
	#cat "$SUBS"/hosts.txt | parallel -j 5 --bar --shuf gobuster dir -u {} -t 50 -w wordlist.txt -l -e -r -k -q -o "$DIRSCAN"/"$sub".txt
	#"$HOME"/go/bin/gobuster dir -u "$line" -w "$WORDLIST"/wordlist.txt -e -q -k -n -o "$DIRSCAN"/out.txt
	for url in $(cat "$SUBS"/hosts.txt); do
		gobuster -u $url -w "$gobuster_wordlist" >> "$DIRSCAN"/gobuster.txt
	done
	cat "$DIRSCAN"/gobuster.txt | grep -v "403\|.min.js" > "$DIRSCAN"/not_st_403.txt
	#cat "$DIRSCAN"/gobuster.txt | grep -v "200" > "$DIRSCAN"/st_200.txt
	echo -e "[$GREEN+$RESET] Directory brute-force finished"

}
: 'Check for Vulnerabilities'
runNuclei() {
	startFunction  "Nuclei Basic-detections"
	nuclei -l "$SUBS"/hosts.txt -t generic-detections/ -c 50 -H "x-bug-bounty: $hackerhandle" -o "$NUCLEISCAN"/generic-detections.txt
	startFunction  "Nuclei CVEs Detection"
	nuclei -l "$SUBS"/hosts.txt -t cves/ -c 50 -H "x-bug-bounty: $hackerhandle" -o "$NUCLEISCAN"/cve.txt
	startFunction  "Nuclei default-creds Check"
	nuclei -l "$SUBS"/hosts.txt -t default-credentials/ -c 50 -H "x-bug-bounty: $hackerhandle" -o "$NUCLEISCAN"/default-creds.txt
	startFunction  "Nuclei dns check"
	nuclei -l "$SUBS"/hosts.txt -t dns/ -c 50 -H "x-bug-bounty: $hackerhandle" -o "$NUCLEISCAN"/dns.txt
	#startFunction  "Nuclei files check"
	#nuclei -l "$SUBS"/hosts.txt -t files/ -c 50 -H "x-bug-bounty: $hackerhandle" -o "$NUCLEISCAN"/files.txt
	startFunction  "Nuclei Panels Check"
	nuclei -l "$SUBS"/hosts.txt -t panels/ -c 50 -H "x-bug-bounty: $hackerhandle" -o "$NUCLEISCAN"/panels.txt
	startFunction  "Nuclei Security-misconfiguration Check"
	nuclei -l "$SUBS"/hosts.txt -t security-misconfiguration/ -c 50 -H "x-bug-bounty: $hackerhandle" -o "$NUCLEISCAN"/security-misconfiguration.txt
	#startFunction  "Nuclei Technologies Check"
	#nuclei -l "$SUBS"/hosts.txt -t technologies/ -c 50 -H "x-bug-bounty: $hackerhandle" -o "$NUCLEISCAN"/technologies.txt
	startFunction  "Nuclei Tokens Check"
	nuclei -l "$SUBS"/hosts.txt -t tokens/ -c 50 -H "x-bug-bounty: $hackerhandle" -o "$NUCLEISCAN"/tokens.txt
	startFunction  "Nuclei Vulnerabilties Check"
	nuclei -l "$SUBS"/hosts.txt -t vulnerabilities/ -c 50 -H "x-bug-bounty: $hackerhandle" -o "$NUCLEISCAN"/vulnerabilties.txt
	echo -e "[$GREEN+$RESET] Nuclei Scan finished"
}

: 'Setup screenshot results on the target IP address'
makePage() {
	startFunction "HTML webpage"
	cd /var/www/html/ || return
	sudo chmod -R 755 .
	sudo cp -r "$SCREENSHOTS" /var/www/html/$domain
	sudo chmod a+r -R /var/www/html/$domain/*
	cd "$HOME" || return
	echo -e "[$GREEN+$RESET] Scan finished, start doing some manual work ;)"
	echo -e "[$GREEN+$RESET] The screenshot results page, nuclei results directory and the meg results directory are great points!"
	echo -e "[$GREEN+$RESET] screenshot results page: http://$(ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -n 1)/$domain/screenshots/report.html"
}

notifySlack() {
	startFunction "Trigger Slack Notification"
	source "$HOME"/ReconPi/configs/tokens.txt
	export SLACK_WEBHOOK_URL="$SLACK_WEBHOOK_URL"
	echo -e "ReconPi $domain scan completed!" | slackcat
	totalsum=$(cat $SUBS/hosts.txt | wc -l)
	echo -e "$totalsum live subdomain hosts discovered" | slackcat

	posibbletko="$(cat $SUBS/takeovers.txt | wc -l)"
	if [ -s "$SUBS/takeovers.txt" ]
		then
        echo -e "Found $posibbletko possible subdomain takeovers." | slackcat
	else
        echo "No subdomain takeovers found." | slackcat
	fi

	if [ -f "$NUCLEISCAN/cve.txt" ]; then
	echo "CVE's discovered:" | slackcat
    cat "$NUCLEISCAN/cve.txt" | slackcat
		else 
    echo -e "No CVE's discovered." | slackcat
	fi

	if [ -f "$NUCLEISCAN/files.txt" ]; then
	echo "files discovered:" | slackcat
    cat "$NUCLEISCAN/files.txt" | slackcat
		else 
    echo -e "No files discovered." | slackcat
	fi

	echo -e "[$GREEN+$RESET] Done."
}

: 'Execute the main functions
source "$HOME"/bughunter/tools/recon/configs/tokens.txt || return
export SLACK_WEBHOOK_URL="$SLACK_WEBHOOK_URL"
'

: 'Last functions'

# Get {401,403,404} status code
st400(){
	python3 "$SCRIPTS"/st_400.py --urls "$ARCHIVE"/clean_urls.txt -o "$URLS" -t 200 -d 
}

# Test http auth default creds
httpAUTH(){
	python3 "$SCRIPTS"/http_auth.py --urls "$URLS"/401_statusCode.txt  --creds "$WORDLIST"/httpAUTH/all.txt -o "$SCANDIR"/httpAUTH_broken_authentication.txt # -s 1
}

# Pass urls to burpsuite
passURLS_burpsuite(){
	python3 "$SCRIPTS"/proxy_urls.py --urls "$ARCHIVE"/clean_urls.txt -t 5 -s 20 -d
}

# Crawlling usuing zaproxy
#zaproxy(){
 #echo ""
#}

# use rediect test tool
redirect_test(){
	python3 "$SCRIPTS"/redir_trick.py --urls "$ARCHIVE"/clean_urls.txt -m -o "$SCANDIR"/redir_trick.txt
}

# function to test tools
test_tools(){
	Test bin subfinder
	Test bin subjack
	Test bin aquatone
	Test bin httprobe
	Test bin assetfinder
	Test bin waybackurls
	Test bin meg
	Test bin tojson
	Test bin unfurl
	Test bin gf
	Test bin urlive
	Test bin sqlmap
	Test bin anew
	Test bin ffuf
	Test bin gobuster
	Test bin amass
	Test bin getJS
	Test bin gau
	Test bin crobat
	Test bin slackcat
	Test bin github-subdomains
	Test bin shuffledns
	Test bin dnsprobe
	Test bin nuclei
	#Test bin cf-check
	Test bin hakrawler
	Test bin dalfox
	Test bin naabu
	Test bin chaos
	Test bin httpx
	Test path file "$TOOLS"/S3Scanner/s3scanner.py

}


install(){
displayMainInfo
basicRequirements
golangInstall
golangTools
additionalTools
setupDashboard
finalizeSetup
}

Update(){
	# set here all update tools
	nuclei -update-templates
}

requments(){
	displayMainInfo
	checkDirectories
	gatherResolvers
	html_report
	echo -e "$RED report save in : $RESULTDIR/index.html $RESET"
}


mini(){
	requments
	gatherSubdomains
	gatherIPs
	fetchArchive
}

small(){
	mini
	checkTakeovers
	awsMisconfiguration
	getCNAME
	jsEndpoints
	startGfGetParams
}

medium(){
	small
	runNuclei
	st400
	httpAUTH
	#makePage
}

large(){
	medium
	crawler
	gatherScreenshots
	startMeg
	startGfScan
	goBuster
	redirect_test
	portScan
}

bugs(){
	mini
	checkTakeovers
	st400
	httpAUTH
	awsMisconfiguration
	startGfGetParams
	jsEndpoints
	runNuclei
	goBuster
}

helpMsg(){
	echo -e "usage: tool $GREEN[--help] [--install] [--update] [--requments] [--subdomains] [--takeovers] [--awsmisc] [--cname] [--ips] [--screenshot] [--crawl] [--archive] [--jsendpoints] [--gfparams] [--gfscan] [--meg] [--gobuster] [--nuclei] [--makepage] [--low] [--medium] [--hard] $RESET\n
	$GREEN ./recon.sh domain.com --bugs $RESET
optional arguments:
  --help \t show this help message and exit
  --test \t test all tools then exit
  --install \t install all requments tool 
  --update \t update tools and templates 
  --requments $RESET \t make requments things [Required] if else levels
  --subdomains \t gather subdomains
  --takeovers \t check subdomains takeovers
  --awsmisc \t check aws server takeovers
  --cname \t get cname subs
  --ips \t\t gather ips,cidr
  --screenshot \t gather screenshots subdomains
  --crawl \t make crawlling on all subdomains
  --archive \t get urls from web-archive site 
  --jsendpoints  gather endpoints from js files 
  --gfparams \t gather param bugs via gf tool [xss,sqli,ssrf,redirect,idor,paths, etc..]
  --gfscan \t scan via gf 
  --meg \t run meg tool
  --gobuster \t run gobuster tool on all subds [Directory bruteforce]
  --nuclei \t run nuclei scanner [cves,panel,etc..]
  --makepage \t copy results in /var/www/html and etc..

  --mini \t [subdomains - ips - archive]
  --low \t functions [subdomains , takeovers , awsmisc , cname , ips , archive , js_endpoints , gf_params]
  --medium \t functions [low option , nuclei]
  --full \t functions [medium option , meg , gf_scanner , gobuster , portscan]
  --bugs \t fast testing and focus on bugs 
$RED # if you want run determine functions should make --requments --subdomains $RESET this is important
	"
}


# idiomatic parameter and option handling  
while test $# -gt 0
do
    case "$1" in

    	-h) helpMsg
		  ;;

    	--help) helpMsg
		  ;;

    	--test) test_tools
		  ;;

    	--update) Update
		  ;;

    	--install) install
		  ;;

        --mini) mini
            ;;

        --small) low
            ;;

        --medium) medium
            ;;

        --full) large
            ;;

        --bugs) bugs
            ;;

        --requments) requments
            ;;

        --subdomains) gatherSubdomains
            ;;

        --takeovers) checkTakeovers
            ;;

        --awsmisc) awsMisconfiguration
            ;;

        --cname) getCNAME
            ;;

        --ips) gatherIPs
            ;;

        --screenshot) gatherSubdomains
            ;;

        --crawl) crawler
            ;;

        --archive) fetchArchive
            ;;

        --jsendpoints) jsEndpoints
            ;;

        --gfparams) startGfGetParams
            ;;

        --gfscan) startGfScan
            ;;

        --meg) startMeg
            ;;

        --gobuster) goBuster
            ;;

        --nuclei) runNuclei
            ;;

        --makepage) makePage
            ;;

        --*) echo -e "\nbad option $1\n"
            ;;
        *) echo "argument $1"
            ;;

    esac
    shift
done

if [ -d "$RESULTDIR"/$domain/recon ]
then
	echo -e "$GREEN The results saved here.. \n 1- results \t[$RESULTDIR] \n 2- recon \t[$RECONDIR] \n 3- scan \t[$SCANDIR]"
fi

if [ -d  "$RESULTDIR"/$domain ]
then
	zip -qr "$RESULTDIR/$domain".zip "$RESULTDIR"/$domain
	echo -e "\n $GREEN zip recon is done $RESET \n"
fi

: '
	After finish tool must be run:
	python3 zaproxy_control.py --urls "$ARCHIVE"/clean_urls.txt -c -o  "$ARCHIVE"/spidering_urls.txt [to run again gf on all params]
	bash scripts/mini_parts/gf.sh domain.com 


'

