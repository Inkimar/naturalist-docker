#!/bin/bash

BASE=/media/buffalo/dina-data/naturalist
ARTIFACT=test_nf-mediafiles.tgz
DST=srv/data

#SRC=/media/buffalo/dina-data/naturalist/test_nf-mediafiles.tgz
#mkdir -p srv/data
test -f ${DST}/${ARTIFACT} || cp ${BASE}/${ARTIFACT}  ${DST} && tar xvfz $SRC --strip-components=2
#cd srv/data && tar xvfz $SRC --strip-components=2
