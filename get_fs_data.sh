#!/bin/bash
scp -i ~/.ssh/build.pem ubuntu@test.naturforskaren.se:/tmp/nf-data.tgz srv/data .
cd srv/data
tar xvfz nf-data.tgz --strip-components=2
