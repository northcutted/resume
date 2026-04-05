ARG PANDOC_VERSION=3.6.3
ARG TARGETARCH

# Builder stage to download and extract Pandoc binary securely
FROM alpine:3.19 AS builder
ARG PANDOC_VERSION
ARG TARGETARCH

RUN apk add --no-cache curl tar gzip

RUN if [ "$TARGETARCH" = "arm64" ]; then ARCH="arm64"; else ARCH="amd64"; fi && \
    curl -L https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-linux-${ARCH}.tar.gz -o /tmp/pandoc.tar.gz && \
    tar -xzf /tmp/pandoc.tar.gz -C /tmp && \
    mv /tmp/pandoc-${PANDOC_VERSION}/bin/pandoc /usr/bin/pandoc

# Final runtime image
FROM cgr.dev/chainguard/wolfi-base:latest

# Install dependencies required by the app and the GitHub Actions runner
RUN apk add --no-cache \
    nodejs \
    npm \
    chromium \
    dumb-init \
    bash \
    git \
    zip \
    busybox

# Copy pandoc from builder
COPY --from=builder /usr/bin/pandoc /usr/bin/pandoc

WORKDIR /app

# Create output directory and set ownership to Chainguard's default non-root user
RUN mkdir -p output && chown -R nonroot:nonroot /app

# Switch to non-root user
USER nonroot

WORKDIR /app

COPY --chown=nonroot:nonroot package.json package-lock.json* ./

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Use cache mount to speed up npm install
RUN --mount=type=cache,target=/home/nonroot/.npm,uid=65532,gid=65532 \
    npm ci --omit=dev

COPY --chown=nonroot:nonroot --chmod=755 build.sh ./build-resume
COPY --chown=nonroot:nonroot scripts/ styles/ assets/ ./

# Allow node to find modules in /app/node_modules even when running from /data
ENV NODE_PATH=/app/node_modules \
    NODE_ENV=production

# Use dumb-init to handle PID 1 signals (Ctrl+C, SIGTERM) correctly
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/app/build-resume"]
