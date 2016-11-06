ME=$(USER)
DOCKERHUB_VER=v0.2

#all: build prepare up
all: db up

db:
	@echo "Firing up the database"
	./get_db_data.sh
	docker-compose up -d db

up: db
	@echo "Firing up naturforskaren-vanilla"
	docker-compose up -d

	@echo "Please make sure you have naturforskaren.dina-web.net in your /etc/hosts!"

	#echo "Opening app!"
	#firefox https://naturforskaren.dina-web.net/naturalist/

build:
	#docker-compose build --no-cache as
	@cd wildfly-custom && test -f wait-for-it.sh || \
		(wget https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && \
	chmod +x wait-for-it.sh)

	@docker build -t dina/naturalist:${DOCKERHUB_VER} wildfly-custom

release:
	@echo "if you are not logged in , then you must type 'docker login' and enter your credentials"
	@docker push dina/naturalist:${DOCKERHUB_VER}

init:

	echo "Installing image files"
	./get_fs_data.sh

	echo "Installing app file (.war)"
	./get_war.sh

	echo "Installing nginx certs and DINA favicon"
	./get_nginx_certs.sh
	

clean: stop rm
	sudo chown -R $(ME):$(ME) nginx-conf nginx-html nginx-certs nginx-logs
	sudo chown -R $(ME):$(ME) mysql-datadir mysql-shr mysql-autoload mysql-conf.d

stop:
	docker-compose stop

rm:
	docker-compose rm -vf

ps:
	docker-compose ps
	

