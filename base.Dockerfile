FROM ubuntu
RUN \
  apt -y update \
  && apt -y upgrade \
  && apt -y install \
    make \
  && apt -y autoremove \
  && apt -y autoclean \
  && apt -y clean