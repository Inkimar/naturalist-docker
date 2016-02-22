#!/bin/bash

#SRC=/media/buffalo/dina-data/naturalist/integrated/naturalist-mediaserver-20160216.war
SRC=/media/buffalo/dina-data/naturalist/integrated/naturalist-20160222.war
cp $SRC srv/deployments

SRC=/media/buffalo/dina-data/naturalist/integrated/mediaserver-nf.ear
cp $SRC srv/deployments
