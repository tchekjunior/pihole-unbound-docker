FROM pihole/pihole:latest
LABEL maintainer="tchekjunior"
ENV NAME=pihole-unbound \
    PIHOLE_UNBOUND_VERSION=2021.12.20

RUN set -x  \
    && groupadd unbound  \
    && useradd -g unbound -s /etc -d /dev/null unbound  \
    && apt-get update \
    && apt-get install --no-install-recommends -y \
        build-essential \
        unbound \
    && apt-get purge -y --auto-remove \
    && rm -rf \
        /tmp/* \
        /var/tmp/* \
        /var/lib/apt/lists/* \
    && mkdir -p /data/unbound \
    && cp -rfp  /etc/unbound /data \
    && rm -rf  /etc/unbound

COPY ./data /data

RUN chmod +x /data/start_init.sh \
    && cp -pf /data/lighttpd-external.conf /etc/lighttpd/external.conf 

LABEL org.opencontainers.image.version=${PIHOLE_UNBOUND_VERSION} \
      org.opencontainers.image.title="tchekjunior/pihole-unbound-docker" \
      org.opencontainers.image.description="pihole and unbound, a validating, recursive, and caching DNS resolver" \
      org.opencontainers.image.url="https://github.com/tchekjunior/pihole-unbound-docker" \
      org.opencontainers.image.vendor="tchekjunior" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.source="https://github.com/tchekjunior/pihole-unbound-docker"

EXPOSE 5335/tcp
EXPOSE 5335/udp

HEALTHCHECK --interval=30s --timeout=30s --start-period=10s --retries=3 CMD drill @127.0.0.1 cloudflare.com || exit 1

ENTRYPOINT /data/start_init.sh

