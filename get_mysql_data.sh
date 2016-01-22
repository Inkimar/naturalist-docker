#!/bin/bash
ssh -i ~/.ssh/build.pem -fNL 23306:127.0.0.1:3306 ubuntu@test.naturforskaren.se
mysqldump --single-transaction --quick -h 127.0.0.1 --port=23306 -u root -pAkl9x! \
	--databases taxonpages_v2 | pv > mysql-autoload/taxonpages_v2.sql
mysqldump --single-transaction --quick -h 127.0.0.1 --port=23306 -u root -pAkl9x! \
	--databases media_nf_20151014 | pv > mysql-autoload/media_nf.sql
