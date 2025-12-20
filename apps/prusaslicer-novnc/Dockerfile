ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG CHANNEL
ARG TARGETARCH
ARG VERSION

FROM ghcr.io/angelnu/ubuntu-novnc:24.04@sha256:86cdd61197e9f53d9d40008689a20423e1031196596eddfd792644a9feebd5d2
ARG VERSION
ARG APP_UID=33
ARG APP_GID=33

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends flatpak curl jq openssh-client rsync ca-certificates tar xzip gzip bzip2 zip unzip locales locales-all \
            libglu1-mesa libgtk-3-0 libegl1 libwebkit2gtk-4.1-0 && \
    rm -rf /var/lib/apt/lists

RUN deluser www-data \
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

ENV FLATPAK_GL_DRIVERS=dummy
RUN flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
RUN flatpak install -y flathub com.prusa3d.PrusaSlicer

COPY ./apps/prusaslicer-novnc/config/prusaslicer.conf /etc/supervisord.d/