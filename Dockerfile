FROM --platform=$BUILDPLATFORM caddy:2.11.3-builder AS builder

ARG TARGETOS
ARG TARGETARCH

RUN CGO_ENABLED=0 \
    GOOS=$TARGETOS \
    GOARCH=$TARGETARCH \
    xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/mholt/caddy-dynamicdns

FROM caddy:2.11.3

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
