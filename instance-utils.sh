#!/bin/bash

# colors
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
EC="\e[0m"

# functions sections

# download aws_cli from aws website
download_aws_cli()
{
	if [[ $(id -u ) == '0' ]]
	then
		set -e
		${f_clean} &> /dev/null
		curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
		# download aws_cli signature file
		curl -o awscliv2.sig https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip.sig
		gpg --import public_key && echo "imported!"
		${f_verify}
	else
		printf "${RED}aws cli not found${EC}\n"
		printf "${RED}required root permission to install!\n"
		exit 1
	fi
}

    f_download=download_aws_cli
# verify downloaded zip file and checksum fingerprints
verify_aws_cli_sig()
{
	verify_step1="$(gpg --verify awscliv2.sig awscliv2.zip &> .verification)"
	verify_step2="$(cat .verification | grep 475C)"
    if [[ ${verify_step2} ]]
    then
	    printf "verification:\t[${GREEN}OK${EC}]\n"
	    printf "installing aws cli...\n"
	    ${f_install} && ${f_clean} || ${f_clean}
    else
	    printf "verification:\t[${RED}FAILED${EC}]\n"
	    printf "redownloading new package...\n"
	    ${f_clean}
	    ${f_download}
    fi
}
    f_verify=verify_aws_cli_sig

install_aws()
{
	rm -rf aws
	unzip awscliv2.zip &> /dev/null
	sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update &> /dev/null
	printf "\n${GREEn}aws cli was installed${EC}\n"
	$0 launch
}
    f_install=install_aws

clean_aws_file()
{
    ls | grep awscliv2 | xargs rm -rf
    rm -rf .verification aws
}
    f_clean=clean_aws_file
