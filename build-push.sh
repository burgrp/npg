#!/bin/sh

set -e
docker build -t burgrp/npg .
docker push burgrp/npg

docker build -f Dockerfile-rpi -t burgrp/npg-rpi .
docker push burgrp/npg-rpi