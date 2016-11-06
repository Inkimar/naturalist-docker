#!/bin/bash

BASE=/media/buffalo/dina-data/naturalist
ARTIFACT=taxonpages_v2.sql
DST=mysql-autoload

echo " if there is no artifact -(cp from Buffalo)-> ${BASE}/${ARTIFACT}  ${DST}"
test -f ${DST}/${ARTIFACT} || cp ${BASE}/${ARTIFACT}  ${DST}
