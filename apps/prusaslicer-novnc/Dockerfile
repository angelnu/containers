ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG CHANNEL
ARG TARGETARCH
ARG VERSION

FROM --platform=$TARGETPLATFORM ghcr.io/angelnu/debian-novnc:12.5@sha256:70bdcd5d281289c22cc64bca1720004bad64183dd82460602b69d0626fb14c32
ARG VERSION
ARG APP_UID=33
ARG APP_GID=33

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends curl jq openssh-client rsync ca-certificates tar xzip gzip bzip2 zip unzip locales locales-all \
            libglu1-mesa libgtk-3-0 libegl1 && \
    rm -rf /var/lib/apt/lists

RUN PRUSASLICER_URL=$(curl -sX GET https://api.github.com/repos/prusa3d/PrusaSlicer/releases/tags/version_${VERSION}| jq -r '.assets[] | select(.browser_download_url|test("linux-x64-(?!GTK3).+.tar.bz2$"))| .browser_download_url') \
  && mkdir -p /app \
  && curl -sSL ${PRUSASLICER_URL} | tar -xj -C /app --strip-components 1 \
  && deluser www-data \
  && groupadd --gid $APP_GID app \
  && useradd -g app --uid $APP_UID --create-home --home-dir /home/app --shell /bin/bash app \
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
  && chown -R 33:33 /app /home/app /prints /configs

COPY ./apps/prusaslicer-novnc/config/prusaslicer.conf /etc/supervisord.d/