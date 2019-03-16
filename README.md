# Qt5 cross-compile GCC environment

Ubuntu GCC Qt environment for Windows builds.

Currently static only.

After start it executes `qmake && make` by default.

Available images:

* **`latest`** image contains latest available x86 version Qt.
* **`x.y`** image contains exact x86 version of Qt.
* **`...-lite`** image contains same version of Qt but without packages required to build environment itself. Eg. it doesn't contain `git` or system `g++`. It is about 700 MB lighter than corresponding **`x.y`** image. Probably it's better option for CI.
* **`...-x64`** image contains x64 version of same Qt environment.

These images are ready to build Qt program. All you need is to put sources into `<source_dir>` and run image:

    docker run --rm -v <source_dir>:/project/source -v <build_dir>:/project/build dixaba/qt5-gcc-cross:latest

Builded program will be in `<build_dir>/release` directory.
