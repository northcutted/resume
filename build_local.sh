#!/bin/bash

# Detect architecture for build args (simulating BuildKit's TARGETARCH)
ARCH=$(uname -m)
case $ARCH in
    x86_64)
        TARGETARCH="amd64"
        ;;
    aarch64|arm64)
        TARGETARCH="arm64"
        ;;
    *)
        TARGETARCH="amd64" # Default fallback
        ;;
esac

# 1. Build the image (or pull it if you prefer)
podman build --build-arg TARGETARCH=$TARGETARCH -t resume-local .

# 2. Run the container to generate output
# We mount the current directory to /data in the container
podman run --rm -v $(pwd):/data -w /data resume-local build-resume

echo "Build complete! Check the 'output' folder."
