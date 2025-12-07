ARG PANDOC_VERSION=3.6.3
ARG TARGETARCH

FROM node:22-bookworm-slim

ARG PANDOC_VERSION=3.6.3
ARG TARGETARCH

ADD https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-1-${TARGETARCH}.deb /tmp/pandoc.deb

# Install Chromium (installs all needed shared libs) and Pandoc dependencies
# We combine updates and installs to keep the layer small
RUN apt-get update && apt-get install -y --no-install-recommends \
    chromium \
    /tmp/pandoc.deb \
    && rm /tmp/pandoc.deb \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package.json package-lock.json* ./

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Use cache mount to speed up npm install
RUN --mount=type=cache,target=/root/.npm \
    npm install

COPY . .

# Fix permissions and setup path for build script
RUN chmod +x build.sh && \
    ln -s /app/build.sh /usr/local/bin/build-resume

# Allow node to find modules in /app/node_modules even when running from /data
ENV NODE_PATH=/app/node_modules

CMD ["build-resume"]
