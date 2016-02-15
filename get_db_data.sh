#!/bin/bash

SRC=/media/buffalo/dina-data/naturalist/taxonpages_v2.sql
cp $SRC mysql_nf-autoload

SRC=/media/buffalo/dina-data/naturalist/integrated/nf_media-201600203.sql
cp $SRC mysql_media-autoload
