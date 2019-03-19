FROM ubuntu
RUN \
  apt -y update \
  && apt -y upgrade \
  && apt -y install \
    autoconf \
    automake \
    autopoint \
    bash \
    bison \
    bzip2 \
    flex \
    g++ \
    g++-multilib \
    gettext \
    git \
    gperf \
    intltool \
    libc6-dev-i386 \
    libgdk-pixbuf2.0-dev \
    libltdl-dev \
    libssl-dev \
    libtool-bin \
    libxml-parser-perl \
    lzip \
    make \
    openssl \
    p7zip-full \
    patch \
    perl \
    pkg-config \
    python \
    ruby \
    sed \
    unzip \
    wget \
    xz-utils \
  && apt -y autoremove \
  && apt -y autoclean \
  && apt -y clean 
RUN mkdir /opt/x86
WORKDIR /opt/x86
RUN git clone https://github.com/mxe/mxe.git \
   && cp -r /opt/x86 /opt/x64
WORKDIR /opt/x86/mxe
RUN make --jobs=$(nproc) JOBS=$(nproc) MXE_TARGETS='i686-w64-mingw32.static' qtbase && make clean-junk && make clean-pkg
WORKDIR /opt/x64/mxe
RUN make --jobs=$(nproc) JOBS=$(nproc) MXE_TARGETS='x86_64-w64-mingw32.static' qtbase && make clean-junk && make clean-pkg
ENV PATH="${PATH}:/opt/x86/mxe/usr/bin:/opt/x64/mxe/usr/bin"
RUN ln -s /opt/x86/mxe/usr/bin/i686-w64-mingw32.static-qmake-qt5 /usr/bin/qmake
RUN ln -s /opt/x64/mxe/usr/bin/x86_64-w64-mingw32.static-qmake-qt5 /usr/bin/qmake64
WORKDIR /project/build
CMD qmake /project/source && make -j $(nproc)