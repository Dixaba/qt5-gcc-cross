#!/bin/bash

if [ -z "$REPONAME" ]; 
  then 
    REPONAME=dixaba/qt5-gcc-cross;
fi

if [ $# -gt 0 ];
then
  NAME=$1;
  FILENAME=$(sed -e 's/\-/\./g; s/latest\.\?//; s/$/\.Dockerfile/; s/^\.//' <<< $NAME);
  if [ -e $FILENAME ];
  then
    docker build -f $FILENAME -t $REPONAME:$NAME .
    VERSION=$(grep -oP 'Using Qt version \K[0-9.]+' <<< $(docker run --rm $REPONAME:$NAME qmake --version));
    
    if [ $# -eq 2 ] && [ $2 = 'tag' ];
      then
        docker image tag $REPONAME:$NAME $REPONAME:$(sed "s/latest/$VERSION/" <<< $NAME);
    fi

  else
    echo "No such Dockerfile found!";
  fi
else 
  echo "Provide imagename to build like \"$0 latest\"";
fi