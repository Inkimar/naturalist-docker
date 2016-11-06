#!/bin/bash

BASE=/media/buffalo/dina-data/naturalist
ARTIFACT=naturalist.war
DST=wildfly-custom/customization

echo " if there is no artifact - cp ${BASE}/${ARTIFACT}  ${DST}"
test -f ${DST}/${ARTIFACT} || cp ${BASE}/${ARTIFACT}  ${DST}
