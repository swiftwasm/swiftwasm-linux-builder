FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -q update && \
    apt-get -q install -y \
      apt-transport-https ca-certificates git ninja-build clang python \
      software-properties-common curl tzdata screen htop sudo vim

RUN apt-get clean

RUN adduser --disabled-password --gecos '' builder --shell /bin/bash
RUN adduser builder sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER builder

RUN mkdir -p /home/builder/source

WORKDIR /home/builder/source

RUN git clone https://github.com/swiftwasm/swift.git
RUN df -h
RUN cd swift && bash ./utils/webassembly/ci.sh || true

WORKDIR /home/builder/source/swift
