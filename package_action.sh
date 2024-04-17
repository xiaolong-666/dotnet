#/bin/bash

set -x

ARCH=$(dpkg --print-architecture)
#if [ ${ARCH} == "amd64" ]; then
#    arch="x64"
#elif [ ${ARCH} == "arm64" ]; then
#    arch="arm64"
#else
#    echo "Unsupported architecture: ${ARCH}"
#    exit 1
#fi

mkdir -p release
cat upstream/dotnet-sdk-*-linux-${ARCH}.tar.gz.* | tar zx -C release
#tar zxf upstream/dotnet-sdk-*-linux-${ARCH}.tar.gz -C release

if [ ${ARCH} == "loongarch64" ]; then
    # loongarch 架构，源码包存在x86的二进制文件，需要删除，不然计算动态库失败
    find release -type f  -exec file {} \; | grep "x86-64" | cut -d: -f1 | xargs rm -f
fi

