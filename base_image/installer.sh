#!/bin/bash
# Author : sudhay
yum -y groupinstall development
yum -y install zlib-devel
yum -y install openssl-devel
yum -y install wget

# This is a duplicate of the apt-get libffi-dev below
# Need to determine which one to keep through testing it out
yum -y install libffi-devel

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

apt-get install libffi-dev
apt-get install libpython-dev
apt-get install python3-lxml

# Install Python 3.6
wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tar.xz
tar xJf Python-3.7.0.tar.xz
cd Python-3.7.0

./configure
make
make install

cd ..
rm Python-3.7.0.tar.xz
rm -rf Python-3.7.0

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py --force-reinstall


# # Create virtualenv running Python 3.6
# pip install --upgrade virtualenv
# virtualenv -p python3 MYVENV
# source MYVENV/bin/activate

# python --version
