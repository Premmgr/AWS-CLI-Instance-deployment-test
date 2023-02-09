#!/bin/bash

# predefined vars from custom.env
source custom.env
source ./instance-utils.sh 

VAR_VPC_ID="${VPC_ID}"
VAR_SUBNET_ID="${SUBNET_ID}"
VAR_AMI_ID="${AMI_ID}"
VAR_SG_ID="${SG_ID}"
VAR_SSH_KEY="${INSTANCE_SSH_KEY}"
VAR_INSTANCE_COUNT="${INSTANCE_COUNT}"
VAR_INSTANCE_TYPE="${INSTANCE_TYPE}"
VAR_INSTANCE_NAME="${INSTANCE_NAME}"
VAR_DISK_NAME="${DISK_NAME}"
VAR_DISK_SIZE="${DISK_SIZE}"
VAR_DOT="${DELETE_ON_TERMINATION}"


# instance creation using insance_var_file with parameter $1
case $1 in
"force-launch")
        printf "${YELLOW}>>>\tpreparing launch instance\n"
	mkdir logs &> /dev/null
        aws ec2 run-instances \
            $(aws ec2 run-instances --image-id "${VAR_AMI_ID}" --count "${VAR_INSTANCE_COUNT}" --instance-type "${VAR_INSTANCE_TYPE}" --key-name "${VAR_INSTANCE_NAME}" --security-group-ids "${VAR_SG_ID}" --subnet-id "${VAR_SUBNET_ID}")
		exit 0

    ;;
"launch")
	if [[ $(which aws) ]]
	then
		printf "${YELLOW}>>>\tpreparing launch instance\n"
		mkdir logs &> /dev/null
		
		$(aws ec2 run-instances --image-id "${VAR_AMI_ID}" --count "${VAR_INSTANCE_COUNT}" --instance-type "${VAR_INSTANCE_TYPE}" --key-name "${VAR_INSTANCE_NAME}" --security-group-ids "${VAR_SG_ID}" --subnet-id "${VAR_SUBNET_ID}")
	else	
		$f_download
	fi
	;;
"install")
	${f_download}
	;;
    *)
        printf "${YELLOW}supported parameters:${EC}\n\n"
	printf "${YELLOW}$0 install\t\t(download and installs aws cli with sha256 verification)${EC}\n\n"
	printf "${YELLOW}$0 force-launch\t\t(launch without verifying aws cli)${EC}\n\n"
	printf "${YELLOW}$0 launch\t\t(launch with aws cli verification)${EC}\n\n"
        printf "${YELLOW}type -h for help${EC}\n"
        exit 1
esac
