# Makefile for build PHP development environment on Docker.

# var
SSH_KEYFILE_NAME=sshkey

sshkey:  
	@ssh-keygen -b 2048 -t rsa -f ./$(SSH_KEYFILE_NAME) -q -N ""
	@mv sshkey.pub ./php/authorized_keys
	@mv sshkey ./php/php-develop.pem
	@chmod 400 ./php/php-develop.pem

clean:
	rm -f authorized_keys
	rm -f php-develop.pem

docker-build:
	@docker-compose -f docker-compose.yml -f docker-compose.nginx.yml build

docker-nginx-up:
	@docker-compose -f docker-compose.yml -f docker-compose.nginx.yml up -d

docker-nginx-down:
	@docker-compose -f docker-compose.yml -f docker-compose.nginx.yml down

docker-httpd-up:
	@docker-compose -f docker-compose.yml -f docker-compose.httpd.yml up -d
  
docker-httpd-down:
	@docker-compose -f docker-compose.yml -f docker-compose.httpd.yml down

docker-bash:
	@docker exec -it devel-php /bin/bash

.PHONY: clean
