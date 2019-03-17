#!/bin/bash

for NAME in latest latest-x64 latest-lite latest-lite-x64 latest-tiny latest-tiny-x64
do
	FILENAME=$(sed -e 's/\-/\./g; s/latest\.\?//; s/$/\.Dockerfile/; s/^\.//' <<< $NAME)
	docker build -f $FILENAME -t dixaba/qt5-gcc-cross:$NAME .
  VERSION=$(grep -oP 'Using Qt version \K[0-9.]+' <<< $(docker run --rm dixaba/qt5-gcc-cross:$NAME qmake --version))
  docker image tag dixaba/qt5-gcc-cross:$NAME dixaba/qt5-gcc-cross:$(sed "s/latest/$VERSION/" <<< $NAME)
done