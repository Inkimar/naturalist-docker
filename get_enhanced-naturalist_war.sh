#!/bin/bash
FILE=naturalist_mediaserver_20160920.war
NEW_FILE=naturalist.war
SRC=/media/buffalo/dina-data/naturalist/integrated/${FILE}
DST=wildfly-custom
test -f $DST/$NEW_FILE || cp $SRC $DST/$NEW_FILE
