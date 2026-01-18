FROM --platform=$BUILDPLATFORM caddy:2.10.2-builder AS builder

ARG TARGETOS
ARG TARGETARCH

RUN CGO_ENABLED=0 \
    GOOS=$TARGETOS \
    GOARCH=$TARGETARCH \
    xcaddy build \
    --with github.com/caddy-dns/cloudflare

FROM caddy:2.10.2

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
