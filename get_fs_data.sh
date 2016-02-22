#!/bin/bash

#The media-files
SRC=/media/buffalo/dina-data/naturalist/integrated/media-files.tgz
cp $SRC srv/data
cd srv/data
tar xvfz media-files.tgz 

#The map-files
SRC=/media/buffalo/dina-data/naturalist/maps/maps.tgz
cp $SRC srv/data
cd srv/data
tar xvfz maps.tgz
