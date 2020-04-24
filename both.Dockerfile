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
COPY --from=dixaba/test:latest /opt/x86/mxe/usr/ /opt/x86/mxe/usr/
COPY --from=dixaba/test:latest-x64 /opt/x64/mxe/usr/ /opt/x64/mxe/usr/
ENV PATH="${PATH}:/opt/x86/mxe/usr/bin:/opt/x64/mxe/usr/bin"
RUN ln -s /opt/x86/mxe/usr/bin/i686-w64-mingw32.static-qmake-qt5 /usr/bin/qmake
RUN ln -s /opt/x64/mxe/usr/bin/x86_64-w64-mingw32.static-qmake-qt5 /usr/bin/qmake64
WORKDIR /project/build
CMD qmake /project/source && make -j $(nproc)