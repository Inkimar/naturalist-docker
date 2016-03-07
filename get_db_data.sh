#!/bin/bash

#common
SRC=/media/buffalo/dina-data/naturalist/taxonpages_v2.sql
cp $SRC mysql_nf-autoload

SRC=/media/buffalo/dina-data/naturalist/integrated/mediaserver_for_nf-20160203.sql
cp $SRC mysql_media-autoload
