wordpress-install
=================

You can use the scripts in this project to install a basic WordPress instance on Amazon Web Services.

Software requirements:

* jq  
  OS X: brew install jq  
  Fedora/RHEL: yum install jq
* packer  
  OS X: brew tap homebrew/binary; brew install packer  
  Fedora/RHEL: yum install packer
* AWS CLI  
  OS X: brew install awscli  
  Fedora/RHEL: yum install awscli
  
Environment variables:

AWS_ACCESS_KEY_ID=<AWS access key>  
AWS_SECRET_ACCESS_KEY=<AWS secret access key>  
AWS_DEFAULT_REGION (ie. us-east-1)  
SSL_CERTIFICATE_FILE=/path/to/ssl_certificate_file  
SSL_PRIVATE_KEY_FILE=/path/to/ssl_private_key_file  
SSL_CERTIFICATE_CHAIN_FILE=/path/to/ssl_certificate_chain_file  

To perform an installation from scratch:

bin/create-infrastructure.sh && bin/deploy-machine-image.sh $(bin/create-machine-image.sh)
