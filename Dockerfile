FROM ubuntu:jammy

# Define versions for easier maintenance
ARG PANDOC_VERSION=3.8.3
ARG WKHTML_VERSION=0.12.6.1-3
ARG TARGET_ARCH

ADD https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-1-${TARGET_ARCH}.deb /tmp/pandoc-${PANDOC_VERSION}-1-${TARGET_ARCH}.deb
ADD https://github.com/wkhtmltopdf/packaging/releases/download/${WKHTML_VERSION}/wkhtmltox_${WKHTML_VERSION}.jammy_${TARGET_ARCH}.deb /tmp/wkhtmltox_${WKHTML_VERSION}.jammy_${TARGET_ARCH}.deb

# Prevent interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies, tools, and cleanup in a single layer to keep image size down
RUN apt-get update \
    && apt-get install -y --no-install-recommends fonts-liberation \
    # Install packages
    && apt-get install -y "/tmp/pandoc-${PANDOC_VERSION}-1-${TARGET_ARCH}.deb" "/tmp/wkhtmltox_${WKHTML_VERSION}.jammy_${TARGET_ARCH}.deb" \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /data