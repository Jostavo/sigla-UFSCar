#!/bin/bash
cd ~/Documents
mkdir git
cd git

apt-get update
apt-get install git cmake m4 automake libusb-1.0-0-dev libnss3-dev libglib2.0-dev libx11-dev libxv-dev libcurl4-gnutls-dev libtool libpixman-1-dev libssl-dev -y

git clone git://anongit.freedesktop.org/libfprint/libfprint

cd ./libfprint
export LIBFPRINT_DEBUG=2

./autogen.sh
./configure
make
make install

cd ~/Documents/git
git clone https://github.com/open-source-parsers/jsoncpp.git
cd ./jsoncpp
cmake .
make
make install

cd ~/Documents/git
git clone https://github.com/Darkkgreen/trab-PDS.git
cd ./trab-PDS/tools/digital_matcher/
mkdir build
cd build
cmake .. -DDEBUG=ON
make
make install

cd ~/Documents
rm -rf ./git
