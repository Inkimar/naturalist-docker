#!/bin/bash
# files are expanded under '~/srv/data/nf/vffmedia' and '~/srv/data/nf/maps'

BASE=/media/buffalo/dina-data/naturalist
ARTIFACT=test_nf-mediafiles.tgz
DST=srv/data

test -f ${DST}/${ARTIFACT} || cp ${BASE}/${ARTIFACT}  ${DST} && tar xvfz $ARTIFACT --strip-components=2
#cd srv/data && tar xvfz $ARTIFACT --strip-components=2
