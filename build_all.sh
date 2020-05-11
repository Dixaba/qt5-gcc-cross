#!/bin/bash

for NAME in latest-buildx86 latest-buildx64
do
  ./build.sh $NAME
done

for NAME in latest latest-x64 latest-both
do
  ./build.sh $NAME tag
done