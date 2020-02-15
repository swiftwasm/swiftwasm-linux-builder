FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -q update && \
    apt-get -q install -y \
      apt-transport-https ca-certificates git \
      software-properties-common screen htop sudo vim

RUN adduser --disabled-password --gecos '' builder
RUN adduser builder sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER builder

RUN mkdir -p /home/builder/source

WORKDIR /home/builder/source

RUN git clone https://github.com/swiftwasm/swift.git
RUN cd swift && git checkout maxd/split-ci-scripts && \
    chmod +x ./utils/webassembly/linux/install-dependencies.sh && \
    ./utils/webassembly/linux/install-dependencies.sh
    
RUN cd swift && \
    ./utils/webassembly/build-linux.sh --release --debug-swift-stdlib --verbose

WORKDIR /home/builder/source/swift
