FROM ubuntu
RUN \
  apt -y update \
  && apt -y upgrade \
  && DEBIAN_FRONTEND=noninteractive \
  apt -y install \
    make \
  && apt -y autoremove \
  && apt -y autoclean \
  && apt -y clean
COPY --from=dixaba/test:latest-big /opt/x86/mxe/usr/ /opt/x86/mxe/usr/
RUN ln -s /opt/x86/mxe/usr/bin/i686-w64-mingw32.static-qmake-qt5 /usr/bin/qmake
ENV PATH="${PATH}:/opt/x86/mxe/usr/bin"
WORKDIR /project/build
CMD qmake /project/source && make -j $(nproc)