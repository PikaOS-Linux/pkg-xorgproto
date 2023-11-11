#! /bin/bash

DEBIAN_FRONTEND=noninteractive

# Clone Upstream
git clone https://gitlab.freedesktop.org/xorg/proto/xorgproto.git -b xorgproto-2023.2
cp -rvf ./debian ./xorgproto/
cd ./xorgproto/
for i in $(cat ../patches/series) ; do echo "Applying Patch: $i" && patch -Np1 -i ../patches/$i || bash -c "echo "Applying Patch $i Failed!" && exit 2"; done

# Get build deps
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
