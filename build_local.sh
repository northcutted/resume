#!/bin/bash
set -e

# Detect Container Engine
if command -v podman &> /dev/null; then
    ENGINE="podman"
    echo "🐳 Found Podman, using it..."
elif command -v docker &> /dev/null; then
    ENGINE="docker"
    echo "🐳 Found Docker, using it..."
else
    echo "❌ Error: Neither Podman nor Docker found. Please install one of them to continue."
    echo "Visit https://podman.io/getting-started/installation or https://docs.docker.com/get-docker/ for installation instructions."
    exit 1
fi

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

echo "🏗️  Building container image..."
# 1. Build the image
$ENGINE build --build-arg TARGETARCH=$TARGETARCH -t resume-local .

# Attempt to detect REPO_URL if not set
if [ -z "$REPO_URL" ]; then
    REPO_URL=$(git config --get remote.origin.url 2>/dev/null || echo "")
    # Simple conversion from SSH to HTTPS for GitHub
    REPO_URL=${REPO_URL/git@github.com:/https://github.com/}
    REPO_URL=${REPO_URL%.git}
fi

echo "🚀 Generating resume..."
# 2. Run the container to generate output
# We mount the current directory to /data in the container
rm -rf output

# Handle SELinux context for Podman if needed (z flag)
VOLUME_FLAGS="-v $(pwd):/data"
if [ "$ENGINE" == "podman" ] && [ -x "$(command -v getenforce)" ] && [ "$(getenforce)" == "Enforcing" ]; then
     VOLUME_FLAGS="-v $(pwd):/data:Z"
fi

$ENGINE run --rm $VOLUME_FLAGS -w /data -e REPO_URL="$REPO_URL" resume-local

echo "✅ Build complete! Check the './output' folder."
