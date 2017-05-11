!#/bin/bash

cd ~/Documents
mkdir git

sudo apt-get update
sudo apt-get install git cmake libtoolize m4 automake libusb libnss3-dev libglib2.0-dev libx11-dev libxv-dev libcurl4-gnutls-dev

git clone git://anongit.freedesktop.org/libfprint/libfprint

cd ./libfprint
export LIBFPRINT_DEBUG=2

./autogen.sh
./configure
make
sudo make install

cd ~/Documents/git
git clone https://github.com/open-source-parsers/jsoncpp.git
cmake .
make
sudo make install

cd ~/Documents/git
git clone https://github.com/Darkkgreen/trab-PDS.git
cd ./trab-PDS/tools/digital_matcher/
mkdir build
cd build
cmake .. -DEBUG=ON
make
sudo make install

