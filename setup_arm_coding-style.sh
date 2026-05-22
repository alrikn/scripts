#!/bin/bash
set -e

ARCH=$(uname -m)

if [ "$ARCH" = "aarch64" ]; then
    if ! command -v qemu-x86_64-static &> /dev/null; then
        sudo apt update
        sudo apt install -y qemu-user-static
    fi
    docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
fi
