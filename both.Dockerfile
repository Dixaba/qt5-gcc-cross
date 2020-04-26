FROM dixaba/qt5-gcc-cross:latest
COPY --from=dixaba/qt5-gcc-cross:latest-x64 /opt/x64/mxe/usr/ /opt/x64/mxe/usr/
ENV PATH="${PATH}:/opt/x64/mxe/usr/bin"
RUN ln -s /opt/x64/mxe/usr/bin/x86_64-w64-mingw32.static-qmake-qt5 /usr/bin/qmake64
WORKDIR /project/build
CMD qmake /project/source && make -j $(nproc)