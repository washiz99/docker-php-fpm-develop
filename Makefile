# Makefile for build PHP development environment on Docker.

# var
SSH_KEYFILE_NAME=sshkey

sshkey:  
	@ssh-keygen -b 2048 -t rsa -f ./$(SSH_KEYFILE_NAME) -q -N ""
	@mv sshkey.pub authorized_keys
	@mv sshkey php-develop.pem
	@chmod 400 ./php-develop.pem

clean:
	rm -f authorized_keys
	rm -f php-develop.pem
