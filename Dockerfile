# Stage 1: Builder
FROM node:25 AS builder

WORKDIR /app

# Copy package files
COPY package.json ./

# Install dependencies (including devDependencies like qrcode)
RUN npm install

# Stage 2: Final
FROM node:25-slim

# Define versions
ARG PANDOC_VERSION=3.6.3
# Using Bullseye package for wkhtmltopdf as Bookworm is not officially supported
ARG WKHTML_VERSION=0.12.6.1-2
ARG TARGETARCH

# Install system dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       curl \
       ca-certificates \
       fonts-liberation \
       fontconfig \
       xfonts-75dpi \
       xfonts-base \
       gnupg \
    && rm -rf /var/lib/apt/lists/*

# Download packages using ADD
ADD https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-1-${TARGETARCH}.deb /tmp/pandoc.deb
ADD https://github.com/wkhtmltopdf/packaging/releases/download/${WKHTML_VERSION}/wkhtmltox_${WKHTML_VERSION}.bullseye_${TARGETARCH}.deb /tmp/wkhtmltox.deb

# Install downloaded packages and libssl (via curl due to domain differences)
RUN dpkg -i /tmp/pandoc.deb \
    && rm /tmp/pandoc.deb \
    && if [ "$TARGETARCH" = "amd64" ]; then \
      curl -L http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb -o /tmp/libssl.deb; \
    elif [ "$TARGETARCH" = "arm64" ]; then \
      curl -L http://ports.ubuntu.com/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_arm64.deb -o /tmp/libssl.deb; \
    fi \
    && dpkg -i /tmp/libssl.deb \
    && rm /tmp/libssl.deb \
    && apt-get update \
    && apt-get install -y /tmp/wkhtmltox.deb \
    && rm /tmp/wkhtmltox.deb \
    && rm -rf /var/lib/apt/lists/*

# Copy node_modules from builder
COPY --from=builder /app/node_modules /usr/local/lib/node_modules
ENV NODE_PATH=/usr/local/lib/node_modules

COPY --chmod=755 build.sh /usr/local/bin/build-resume

WORKDIR /data