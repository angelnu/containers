ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG CHANNEL
ARG TARGETARCH
ARG VERSION

FROM --platform=$TARGETPLATFORM ghcr.io/angelnu/debian-novnc:12.12@sha256:b65e072493044b410f514d4a3c98ab257901d119c911388b2afc851ab63b8d73
ARG VERSION
ARG APP_UID=33
ARG APP_GID=33

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends curl jq openssh-client rsync ca-certificates tar xzip gzip bzip2 zip unzip locales locales-all \
            libglu1-mesa libgtk-3-0 libegl1 libpci3 && \
    rm -rf /var/lib/apt/lists

RUN DOWNLOAD_URL=$(curl -sX GET https://api.github.com/repos/FreeCAD/FreeCAD/releases/tags/${VERSION}| jq -r '.assets[] | select(.browser_download_url|test(".+Linux-x86_64.*.AppImage$"))| .browser_download_url') \
  && mkdir -p /app/ \
  && curl -sSL ${DOWNLOAD_URL} > /app/freecad.appimage \
  && chmod 755 /app/freecad.appimage \
  && cd /app \
  && ./freecad.appimage --appimage-extract \
  && rm freecad.appimage \
  && deluser www-data \
  && groupadd --gid $APP_UID app \
  && useradd -g app --uid $APP_GID --create-home --home-dir /home/app --shell /bin/bash app \
  && mkdir -p /configs \
  && mkdir -p /prints/ \
  && locale-gen en_US \
  && mkdir /configs/.local \
  && mkdir -p /configs/.config/ \
  && ln -s /configs/.config/ /home/app/ \
  # We can now set the Download directory for Firefox and other browsers. 
  # We can also add /prints/ to the file explorer bookmarks for easy access.
  && echo "XDG_DOWNLOAD_DIR=\"/prints/\"" >> /home/app/.config/user-dirs.dirs \
  && echo "file:///prints prints" >> /home/app/.gtk-bookmarks  \
  && chown -R 33:33 /app/ /home/app/ /prints/ /configs/

COPY ./apps/freecad-novnc/config/*.conf /etc/supervisord.d/