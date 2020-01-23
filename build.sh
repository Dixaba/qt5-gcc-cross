#!/bin/bash

REPONAME=dixaba/qt5-gcc-cross

for NAME in latest-big latest latest-x64 latest-both
do
  FILENAME=$(sed -e 's/\-/\./g; s/latest\.\?//; s/$/\.Dockerfile/; s/^\.//' <<< $NAME)
  docker build -f $FILENAME -t $REPONAME:$NAME .
  VERSION=$(grep -oP 'Using Qt version \K[0-9.]+' <<< $(docker run --rm $REPONAME:$NAME qmake --version))
  docker image tag $REPONAME:$NAME $REPONAME:$(sed "s/latest/$VERSION/" <<< $NAME)
done