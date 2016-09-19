#!/bin/bash
FILE=taxonpages_v2.sql
SRC=/media/buffalo/dina-data/naturalist/${FILE}
DST=mysql_nf-autoload
test -f $DST/$FILE || cp $SRC $DST
