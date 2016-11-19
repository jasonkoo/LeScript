#!/bin/bash

# yum required libs
yum -y   install libtool
yum -y install gcc-c++
yum -y install uuid-devel
yum -y install libuuid-devel

cd /root/mydownload/ledrill
unzip zeromq-tested.zip

# install zeromq
cd /root/mydownload/ledrill
tar -xvf zeromq-2.1.7.tar.gz
cd zeromq-2.1.7
./autogen.sh
./configure
make
make install

# install jzmq
cd /root/mydownload/ledrill
unzip jzmq-master.zip
cd jzmq-master
./autogen.sh
./configure
make
make install

echo "export LD_LIBRARY_PATH=/usr/local/lib" > /etc/profile.d/mdrill.sh
source /etc/profile.d/mdrill.sh


# ./autogen.sh > result.out 2>&1
