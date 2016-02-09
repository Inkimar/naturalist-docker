all: build up

clean: stop rm
	#sudo chown -R $(ME) nginx-conf nginx-html nginx-certs nginx-logs

build:
	docker build --no-cache . 
#	docker build --no-cache -t $(NAME):$(VERSION) . 

up:
	echo "setting up certificates"
	#cp combined.pem nginx-certs/cert.pem
	#cp key.pem nginx-certs/cert.key
	echo "cp taxonpages_v2.sql "
	cp srv/data/taxonpages_v2.sql mysql-autoload
	echo "tar xvfz on mediafiles "
	tar xvfz srv/data/nf-mediafiles.tgz --strip-components=2 -C srv/data/
	rm srv/data/nf-mediafiles.tgz

	docker-compose up -d db
	
	docker-compose up -d as


	# firefox https://beta.dina-web.net

stop:
	docker-compose stop

rm:
	docker-compose rm -vf

reload:
	#docker exec -i dwcollectionsui_ui_1 nginx -s reload

