#!/bin/bash

SRC=/media/buffalo/dina-data/naturalist/integrated/media-files.tgz
cp $SRC srv/data
cd srv/data
tar xvfz media-files.tgz 
