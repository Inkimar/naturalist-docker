ME=$(USER)
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
	echo "Installing nginx certs and DINA favicon"
	./get_nginx_certs.sh
	
build: fetch-sh
	#docker-compose build --no-cache as
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

	#docker exec -it dwsystem_as_1 bash -c 'bin/jboss-cli.sh --connect --command="deploy releases/naturalist.war"'


	docker-compose up -d

	@echo "Local:: Please make sure you have beta-naturforskaren.dina-web.net  in your /etc/hosts!"
	sleep 15

	#echo "Opening app!"
	#firefox https://beta-naturforskaren.dina-web.net/nf-naturalist/&


clean: stop rm
	sudo chown -R $(ME):$(ME) nginx-conf nginx-html nginx-certs nginx-logs
	sudo chown -R $(ME):$(ME) mysql_nf-datadir mysql_nf-shr mysql_nf-autoload mysql_nf-conf.d

stop:
	docker-compose stop

rm:
	docker-compose rm -vf

ps: 
	docker-compose ps

