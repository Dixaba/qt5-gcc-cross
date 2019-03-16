#!/bin/bash

docker build -f latest.Dockerfile -t dixaba/qt5-gcc-cross:latest .
docker build -f latest.x64.Dockerfile -t dixaba/qt5-gcc-cross:latest-x64 .
docker build -f lite.Dockerfile -t dixaba/qt5-gcc-cross:lite .
docker build -f lite.x64.Dockerfile -t dixaba/qt5-gcc-cross:lite-x64 .
