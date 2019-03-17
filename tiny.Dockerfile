FROM ubuntu:16.04
RUN \
  apt -y update \
  && apt -y upgrade \
  && apt -y install \
    make \
  && apt -y autoremove \
  && apt -y autoclean \
  && apt -y clean
COPY --from=dixaba/qt5-gcc-cross:latest /opt/mxe/usr/ /opt/mxe/usr/
RUN ln -s /opt/mxe/usr/bin/i686-w64-mingw32.static-qmake-qt5 /usr/bin/qmake
ENV PATH="${PATH}:/opt/mxe/usr/bin"
WORKDIR /project/build
CMD qmake /project/source && make -j $(nproc)