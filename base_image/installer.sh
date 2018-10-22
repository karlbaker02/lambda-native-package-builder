#!/bin/bash
# Author : sudhay
yum -y groupinstall development
yum -y install zlib-devel
yum -y install openssl-devel
yum -y install wget

# Installing openssl-devel alone seems to result in SSL errors in pip (see https://medium.com/@moreless/pip-complains-there-is-no-ssl-support-in-python-edbdce548852)
# Need to install OpenSSL also to avoid these errors
wget https://github.com/openssl/openssl/archive/OpenSSL_1_0_2l.tar.gz
tar -zxvf OpenSSL_1_0_2l.tar.gz 
cd openssl-OpenSSL_1_0_2l/

./config shared
make
make install
export LD_LIBRARY_PATH=/usr/local/ssl/lib/

cd ..
rm OpenSSL_1_0_2l.tar.gz
rm -rf openssl-OpenSSL_1_0_2l/


# Install Python 3.6
wget https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tar.xz
tar xJf Python-3.6.0.tar.xz
cd Python-3.6.0

./configure
make
make install

cd ..
rm Python-3.6.0.tar.xz
rm -rf Python-3.6.0


# # Create virtualenv running Python 3.6
# pip install --upgrade virtualenv
# virtualenv -p python3 MYVENV
# source MYVENV/bin/activate

# python --version