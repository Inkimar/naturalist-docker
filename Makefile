#!make
##inkimar/naturalist-docker

DOCKERHUB_VER=v0.1

#all: build init up
all: init up


init:
	echo "Retrieving databases - for naturalist and mediaserver"
	./get_naturalist-db_schema.sh

	echo "set up database taxonpages_v2"
	docker-compose up -d db.nf
	#echo "Installing app file (.war)"
	#./get_enhanced-naturalist_war.sh
	#echo "For standalone -Installing the maps"
	#./get_occurance-map_files.sh
	
build: fetch-sh
	echo "fetching app file (.war)"
	./get_enhanced-naturalist_war.sh
	echo "builds"	
	@docker build -t dina/naturalist_enhanced:${DOCKERHUB_VER} wildfly-custom

	echo "Installing nginx certs and DINA favicon"
	./get_nginx_certs.sh


fetch-sh:
	@curl --progress -L -s -o wait-for-it.sh \
		https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && \
		chmod +x wait-for-it.sh
	@test -f wildfly-custom/wait-for-it.sh || \
		mv wait-for-it.sh wildfly-custom/

release:
	docker push  dina/naturalist_enhanced:${DOCKERHUB_VER}

up:
	docker-compose up -d db.nf
	sleep 15
	docker-compose up -d as
	sleep 10

	docker-compose up -d


down:
	@docker-compose down


stop:
	@docker-compose stop

rm:
	@docker-compose rm -vf

ps: 
	@docker-compose ps

browser-test:
	@echo "Local:: Please make sure you have beta-naturforskaren.dina-web.net  in your /etc/hosts!"
	@echo "Opening app!"
	xdg-open https://beta-naturforskaren.dina-web.net/nf-naturalist/&
