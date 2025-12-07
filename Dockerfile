ARG PANDOC_VERSION=3.6.3
ARG TARGETARCH

FROM node:25-bookworm-slim

ARG PANDOC_VERSION
ARG TARGETARCH

RUN apt-get update && apt-get install -y --no-install-recommends \
    chromium \
    ca-certificates \
    curl \
    dumb-init \
    && curl -L https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-1-${TARGETARCH}.deb -o /tmp/pandoc.deb \
    && apt-get install -y /tmp/pandoc.deb \
    && rm /tmp/pandoc.deb \
    && apt-get purge -y --auto-remove curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Create output directory and set ownership of /app to node user
RUN mkdir -p output && chown -R node:node /app

# Switch to non-root user
USER node

COPY --chown=node:node package.json package-lock.json* ./

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Use cache mount to speed up npm install
RUN --mount=type=cache,target=/home/node/.npm,uid=1000,gid=1000 \
    npm ci --omit=dev

COPY --chown=node:node --chmod=755 build.sh ./build-resume
COPY --chown=node:node scripts/ styles/ assets/ ./

# Allow node to find modules in /app/node_modules even when running from /data
ENV NODE_PATH=/app/node_modules \
    NODE_ENV=production

# Use dumb-init to handle PID 1 signals (Ctrl+C, SIGTERM) correctly
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/app/build-resume"]
