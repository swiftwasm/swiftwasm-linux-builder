FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -q update && \
    apt-get -q install -y \
      apt-transport-https ca-certificates git ninja-build clang python \
      software-properties-common uuid-dev libicu-dev icu-devtools libbsd-dev \
      libedit-dev libxml2-dev libsqlite3-dev swig \
      libpython-dev libncurses5-dev pkg-config \
      libblocksruntime-dev libcurl4-openssl-dev \
      systemtap-sdt-dev tzdata rsync wget

RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | apt-key add -
RUN apt-add-repository 'deb https://apt.kitware.com/ubuntu/ xenial main' && \
      apt-get -q update && apt-get -q install -y cmake

WORKDIR /build

RUN git clone https://github.com/swiftwasm/swiftwasm-sdk.git
RUN cd swiftwasm-sdk && git submodule update --init

RUN wget -O wasi-sdk.tar.gz https://github.com/swiftwasm/wasi-sdk/releases/download/20191022.1/wasi-sdk-4.39g3025a5f47c04-linux.tar.gz && \
      tar xfz wasi-sdk.tar.gz && \
      mv wasi-sdk-4.39g3025a5f47c04 ./wasi-sdk

RUN wget -O icu.tar.xz "https://github.com/swiftwasm/icu4c-wasi/releases/download/20190421.3/icu4c-wasi.tar.xz" && \
      tar xf icu.tar.xz

WORKDIR /build/swiftwasm-sdk/swift
