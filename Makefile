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

docker-build:
	@docker build ./ -t devel-php

docker-run:
	@docker run -it -d -p 10022:22 --name devel-php devel-php
  
docker-bash:
	@docker exec -it devel-php /bin/bash

.PHONY: clean
