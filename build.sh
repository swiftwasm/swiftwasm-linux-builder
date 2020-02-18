#!/bin/bash

set -ex

git fetch
git checkout $1
./utils/webassembly/build-linux.sh --release --debug-swift-stdlib --verbose -t || true
