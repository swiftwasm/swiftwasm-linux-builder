FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -q update && \
    apt-get -q install -y \
      apt-transport-https ca-certificates git tzdata \
      software-properties-common screen htop sudo vim

RUN adduser --disabled-password --gecos '' builder
RUN adduser builder sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER builder

RUN mkdir -p /home/builder/source

WORKDIR /home/builder/source

RUN git clone https://github.com/swiftwasm/swift.git
RUN cd swift && git checkout maxd/split-ci-scripts && \
    ./utils/webassembly/linux/install-dependencies.sh
    
RUN cd swift && \
    ./utils/webassembly/build-linux.sh --release --debug-swift-stdlib --verbose && \
    rm -rf ../build/Ninja-ReleaseAssert+stdlib-DebugAssert/swift-linux-x86_64

WORKDIR /home/builder/source/swift
