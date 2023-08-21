#! /bin/bash

DEBIAN_FRONTEND=noninteractive

# Clone Upstream
git clone https://gitlab.freedesktop.org/xorg/proto/xorgproto.git -b xorgproto-2023.2
cp -rvf ./debian ./xorgproto/
cd ./xorgproto/

# Get build deps
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
