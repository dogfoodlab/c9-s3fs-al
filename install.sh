#!/bin/sh
set -eu
cd `dirname $0`

sudo yum -y install \
automake \
gcc-c++ \
fuse \
fuse-devel \
libcurl-devel \
libxml2-devel \
openssl-devel

cd tmp
rm -rf s3fs-fuse
git clone https://github.com/s3fs-fuse/s3fs-fuse.git
cd s3fs-fuse
git checkout v1.85
./autogen.sh
./configure --prefix=/usr/local
make
sudo make install
cd ../..

mkdir -p ~/.local/bin
cp -a ./s3mount ~/.local/bin && chmod +x ~/.local/bin/s3mount
cp -a ./s3umount ~/.local/bin && chmod +x ~/.local/bin/s3umount

echo Install complete.
echo Next you shuld,
echo Attach EC2 to IAM role with s3 policy.
echo Enable user_allow_other on /etc/fuse.conf.
