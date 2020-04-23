#!/bin/bash

REPONAME=dixaba/test

if [ $# = 1 ];
then
  FILENAME=$(sed -e 's/\-/\./g; s/latest\.\?//; s/$/\.Dockerfile/; s/^\.//' <<< $1)
  if [ -e $FILENAME ];
  then
    docker build -f $FILENAME -t $REPONAME:$NAME .
    VERSION=$(grep -oP 'Using Qt version \K[0-9.]+' <<< $(docker run --rm $REPONAME:$NAME qmake --version))
    docker image tag $REPONAME:$NAME $REPONAME:$(sed "s/latest/$VERSION/" <<< $NAME)
  else
    echo "No such Dockerfile found!";
  fi
else 
  echo "Provide imagename to build like \"$0 latest\"";
fi