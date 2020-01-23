#!/bin/bash

REPONAME=dixaba/qt5-gcc-cross

for NAME in latest-bigC latestC latest-x64C latest-bothC
do
  FILENAME=$(sed -e 's/\-/\./g; s/latestC\.\?//; s/$/\.Dockerfile/; s/^\.//' <<< $NAME)
  docker build -f $FILENAME -t $REPONAME:$NAME .
  VERSION=$(grep -oP 'Using Qt version \K[0-9.]+' <<< $(docker run --rm $REPONAME:$NAME qmake --version))
  docker image tag $REPONAME:$NAME $REPONAME:$(sed "s/latest/$VERSION/" <<< $NAME)
done