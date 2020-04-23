#!/bin/bash

for NAME in base latest-big latest latest-x64 latest-both
do
  ./build.sh $NAME
done