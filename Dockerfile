FROM ubuntu:18.04

RUN apt-get -q update && \
    apt-get -q install -y \
      git ninja-build clang python \
      uuid-dev libicu-dev icu-devtools libbsd-dev \
      libedit-dev libxml2-dev libsqlite3-dev swig \
      libpython-dev libncurses5-dev pkg-config \
      libblocksruntime-dev libcurl4-openssl-dev \
      systemtap-sdt-dev tzdata rsync wget

RUN git clone https://github.com/swiftwasm/swift.git
