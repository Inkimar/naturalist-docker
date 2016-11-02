#!/bin/bash
FILE=taxonpages_v2.sql
SRC=https://archive.org/download/naturalist-enhanced_sql-dump/${FILE}
DST=mysql_nf-autoload

test -f $DST/$FILE || (cd $DST && wget $SRC)

#for buffalo
#FILE=taxonpages_v2.sql
#SRC=/media/buffalo/dina-data/naturalist/${FILE}
#test -f $DST/$FILE || cp $SRC $DST
