# This tool allows you to install quickly aws cli and lunch instances with custom.env

before running launch option make sure you have created vpc,vpc-subnet,security-groups,internet gateway otherwise script aws cli will throw an error.

more features can be added to the tool, new version might come around soon.

# usage: 
step 1
if aws cli is not already installed then run following command:
./launch_instance.sh install
this will download and verify <gpg sha256 verification> of aws_cli zip files and install aws cli to path=/usr/bin/local> and path=/usr/bin/aws-cli

step 2  
if you have not created <vpc,vpc-subnet,security-groups,internet gateway> then create at aws console before running ./launch_instance.sh
and modify  >>> custom.env  with your correct information

step 3  
enter following command: aws configure 

then enter your secret information 
example: 

AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE  <<< access key for api calls 
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPx  << secret key for api calls   
Default region name [None]: eu-west-3   
Default output format [None]: yaml  

step 4 

./launch_instance launch 

your instance should launch in some minutes. 

