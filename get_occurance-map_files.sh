#!/bin/bash

#The map-files
FILE=maps.tgz
SRC=/media/buffalo/dina-data/naturalist/maps/maps.tgz
DST=srv/data
test -f $DST/$FILE || cp $SRC $DST
cd $DST
tar xvfz $FILE
