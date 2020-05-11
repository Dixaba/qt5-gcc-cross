FROM ubuntu
RUN \
  apt -y update \
  && apt -y upgrade \
  && DEBIAN_FRONTEND=noninteractive \
  apt -y install \
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
RUN mkdir /opt/x64
WORKDIR /opt/x64
RUN git clone https://github.com/mxe/mxe.git
WORKDIR /opt/x64/mxe
RUN make --jobs=$(nproc) JOBS=$(nproc) MXE_USE_CCACHE= MXE_TARGETS='x86_64-w64-mingw32.static' qtbase qtcharts && make clean-junk && make clean-pkg
ENV PATH="${PATH}:/opt/x64/mxe/usr/bin"
RUN ln -s /opt/x64/mxe/usr/bin/x86_64-w64-mingw32.static-qmake-qt5 /usr/bin/qmake
WORKDIR /project/build
CMD qmake /project/source && make -j $(nproc)