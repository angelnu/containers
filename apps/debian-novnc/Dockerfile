ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG VERSION
ARG CHANNEL
ARG TARGETARCH
ARG VERSION

# Get and install Easy noVNC.
FROM --platform=$BUILDPLATFORM docker.io/golang:1.21.5 AS easy-novnc-build
ARG TARGETARCH

# renovate: datasource=github-releases depName=geek1011/easy-novnc
ARG EASY_NOVNC_VERSION=v1.1.0

WORKDIR /src
RUN go mod init build && \
    go get github.com/geek1011/easy-novnc@$EASY_NOVNC_VERSION && \
    CGO_ENABLED=0 GOARCH=$TARGETARCH go build -o /bin/easy-novnc github.com/geek1011/easy-novnc


# Get TigerVNC and Supervisor for isolating the container.
FROM --platform=$TARGETPLATFORM docker.io/debian:$VERSION

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends openbox tigervnc-standalone-server supervisor gosu \
            lxterminal htop pcmanfm firefox-esr && \
    rm -rf /var/lib/apt/lists && \
    mkdir -p /usr/share/desktop-directories /etc/supervisord.d


COPY --from=easy-novnc-build /bin/easy-novnc /usr/local/bin/
COPY ./apps/debian-novnc/config//menu.xml /etc/xdg/openbox/
COPY ./apps/debian-novnc/config/supervisord.conf /etc/

# HTTP Port
EXPOSE 8080

# VNC Port
EXPOSE 5900

WORKDIR /
CMD ["/usr/bin/supervisord"]