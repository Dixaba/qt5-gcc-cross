#!/bin/bash

REPONAME=dixaba/test

if [ $# = 1 ];
then
  NAME=$1;
  FILENAME=$(sed -e 's/\-/\./g; s/latest\.\?//; s/$/\.Dockerfile/; s/^\.//' <<< $NAME)
  if [ -e $FILENAME ];
  then
    docker build -f $FILENAME -t $REPONAME:$NAME .
    if [ $NAME != "base" ]
    then
      VERSION=$(grep -oP 'Using Qt version \K[0-9.]+' <<< $(docker run --rm $REPONAME:$NAME qmake --version))
      docker image tag $REPONAME:$NAME $REPONAME:$(sed "s/latest/$VERSION/" <<< $NAME)
    fi
  else
    echo "No such Dockerfile found!";
  fi
else 
  echo "Provide imagename to build like \"$0 latest\"";
fi