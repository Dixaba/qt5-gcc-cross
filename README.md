# Qt5 cross-compile GCC environment

[![Build Status](https://dev.azure.com/dixaba/Dixaba/_apis/build/status/qt5-gcc-cross?branchName=master)](https://dev.azure.com/dixaba/Dixaba/_build/latest?definitionId=12&branchName=master)
[![](https://images.microbadger.com/badges/version/dixaba/qt5-gcc-cross.svg)](https://microbadger.com/images/dixaba/qt5-gcc-cross "Get your own version badge on microbadger.com")

Ubuntu GCC Qt environment for Windows builds.

Static builds only.

## Available images

* **`latest`** image contains latest available x86 version Qt.
* **`x.y`** image contains exact x86 version of Qt.
* **`...-x64`** image contains x64 version of same Qt environment.
* **`...-both`** image contains both x86 and x64 versions of Qt.
* **`...-big`** image contains both x86 and x64 versions of Qt and all packages used to build environment itself.

All images have `qmake` as system executable. **`-both`** and  **`-big`** images also has `qmake64`.

 #### Warning: **`...-x64`**'s `qmake` is `qmake` despite it builds x64 application.

After start every image executes `qmake && make` by default.

These images are ready to build Qt programs. All you need is to put sources into `<source_dir>` and run the image:

> docker run --rm -v <source_dir>:/project/source -v <build_dir>:/project/build dixaba/qt5-gcc-cross:latest

Builded program will be in `<build_dir>/release` directory.
