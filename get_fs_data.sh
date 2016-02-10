#!/bin/bash

SRC=/media/buffalo/dina-data/naturalist/test_nf-mediafiles.tgz
mkdir -p srv/data
cd srv/data && tar xvfz $SRC --strip-components=2
