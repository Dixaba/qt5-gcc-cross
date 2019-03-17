# Qt5 cross-compile GCC environment

Ubuntu GCC Qt environment for Windows builds.

Static builds only.

After start it executes `qmake && make` by default.

## Available images

### **`latest`** = **`5.12.2`**

* **`latest`** image contains latest available x86 version Qt.
* **`x.y`** image contains exact x86 version of Qt.
* **`...-tiny`** image contains same version of Qt but without packages required to build environment itself. Eg. it doesn't contain `git` or `g++` - just cross-compile environment. It is much lighter than corresponding **`x.y`** image. Probably it's better option for CI.
* **`...-x64`** image contains x64 version of same Qt environment.

These images are ready to build Qt program. All you need is to put sources into `<source_dir>` and run image:

> docker run --rm -v <source_dir>:/project/source -v <build_dir>:/project/build dixaba/qt5-gcc-cross:latest

Builded program will be in `<build_dir>/release` directory.
