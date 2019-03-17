FROM ubuntu:16.04
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
  && apt -y clean \
  && cd /opt \
  && git clone https://github.com/mxe/mxe.git \
  && cd /opt/mxe \
  && NPROC=$(nproc) \
  && make --jobs=$NPROC JOBS=$NPROC MXE_TARGETS='i686-w64-mingw32.static' qtbase \
  && ln -s /opt/mxe/usr/bin/i686-w64-mingw32.static-qmake-qt5 /usr/bin/qmake \
  && qmake --version \
  && exit 0 \
  || exit 1
ENV PATH="${PATH}:/opt/mxe/usr/bin"
WORKDIR /project/build
CMD qmake /project/source && make -j $(nproc)