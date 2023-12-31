ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG CHANNEL
ARG TARGETARCH
ARG VERSION

FROM --platform=$TARGETPLATFORM ghcr.io/angelnu/ubuntu-novnc:22.04
ARG VERSION
ARG APP_UID=33
ARG APP_GID=33

RUN apt-get update -y && \
    add-apt-repository ppa:kicad/kicad-7.0-releases && \
    DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install kicad && \
    rm -rf /var/lib/apt/lists && \
    echo "foo"

WORKDIR /app
RUN deluser www-data \
  && groupadd --gid $APP_UID app \
  && useradd -g app --uid $APP_GID --create-home --home-dir /home/app --shell /bin/bash app \
  && mkdir -p /app \
  && mkdir -p /configs \
  && mkdir -p /prints/ \
  && mkdir /configs/.local \
  && mkdir -p /configs/.config/ \
  && ln -s /configs/.config/ /home/app/ \
  # We can now set the Download directory for Firefox and other browsers. 
  # We can also add /prints/ to the file explorer bookmarks for easy access.
  && echo "XDG_DOWNLOAD_DIR=\"/prints/\"" >> /home/app/.config/user-dirs.dirs \
  && echo "file:///prints prints" >> /home/app/.gtk-bookmarks  \
  && chown -R 33:33 /home/app/ /app /prints/ /configs/

COPY ./apps/kicad-novnc/config/*.conf /etc/supervisord.d/