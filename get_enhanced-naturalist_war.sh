#!/bin/bash
FILE=naturalist_mediaserver_20160809a.war
SRC=/media/buffalo/dina-data/naturalist/integrated/${FILE}
DST=wildfly-custom
test -f $DST/$FILE || cp $SRC $DST
