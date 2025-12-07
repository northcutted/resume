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

# Attempt to detect REPO_URL if not set
if [ -z "$REPO_URL" ]; then
    REPO_URL=$(git config --get remote.origin.url 2>/dev/null || echo "")
    # Simple conversion from SSH to HTTPS for GitHub
    REPO_URL=${REPO_URL/git@github.com:/https://github.com/}
    REPO_URL=${REPO_URL%.git}
fi

# 2. Run the container to generate output
# We mount the current directory to /data in the container
rm -rf output
podman run --rm -v $(pwd):/data -w /data -e REPO_URL="$REPO_URL" resume-local build-resume

echo "Build complete! Check the 'output' folder."
