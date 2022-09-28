# OpenVPN client + SOCKS proxy
# Usage:
# Create configuration (.ovpn), mount it in a volume
# docker run --volume=something.ovpn:/ovpn.conf:ro --device=/dev/net/tun --cap-add=NET_ADMIN
# Connect to (container):1080
# Note that the config must have embedded certs
# See `start` in same repo for more ideas

FROM alpine:edge

RUN true \
    && echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk add --update-cache --allow-untrusted openvpn curl jq \
    && rm -rf /var/cache/apk/* \
    && true

COPY index.sh /
COPY wo.txt /

ENTRYPOINT [ \
    "openvpn", \
    "--route-up", "/index.sh", \
    "--script-security", "2", \
    "--config", "/ovpn.conf"]
