# Makefile for build PHP development environment on Docker.

# var
SSH_KEYFILE_NAME=sshkey

sshkey:  
	@ssh-keygen -b 2048 -t rsa -f ./$(SSH_KEYFILE_NAME) -q -N ""
	@mv sshkey.pub ./php/authorized_keys
	@mv sshkey ./php/php-develop.pem
	@chmod 400 ./php/php-develop.pem

clean:
	rm -f ./php/authorized_keys
	rm -f ./php/php-develop.pem

dc-build:
	@docker-compose build

dc-up:
	@docker-compose up -d

dc-down:
	@docker-compose down

.PHONY: clean
