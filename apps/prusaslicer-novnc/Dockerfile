ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG CHANNEL
ARG TARGETARCH
ARG VERSION

FROM --platform=$TARGETPLATFORM ghcr.io/angelnu/debian-novnc:12.4
ARG VERSION
ARG SLICER_UID=33
ARG SLICER_GID=33

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends curl jq openssh-client rsync ca-certificates tar xzip gzip bzip2 zip unzip locales locales-all \
            libglu1-mesa libgtk-3-0 libegl1 && \
    rm -rf /var/lib/apt/lists && \
    echo "foo"

WORKDIR /slic3r
RUN PRUSASLICER_URL=$(curl -sX GET https://api.github.com/repos/prusa3d/PrusaSlicer/releases/tags/version_2.7.1| jq -r '.assets[] | select(.browser_download_url|test("linux-x64-(?!GTK3).+.tar.bz2$"))| .browser_download_url') \
  && mkdir -p /slic3r/slic3r-dist \
  && curl -sSL ${PRUSASLICER_URL} | tar -xj -C /slic3r/slic3r-dist --strip-components 1 \
  && deluser www-data \
  && groupadd --gid $SLICER_GID slic3r \
  && useradd -g slic3r --uid $SLICER_UID --create-home --home-dir /home/slic3r slic3r \
  && mkdir -p /slic3r \
  && mkdir -p /configs \
  && mkdir -p /prints/ \
  && locale-gen en_US \
  && mkdir /configs/.local \
  && mkdir -p /configs/.config/ \
  && ln -s /configs/.config/ /home/slic3r/ \
  && mkdir -p /home/slic3r/.config/ \
  # We can now set the Download directory for Firefox and other browsers. 
  # We can also add /prints/ to the file explorer bookmarks for easy access.
  && echo "XDG_DOWNLOAD_DIR=\"/prints/\"" >> /home/slic3r/.config/user-dirs.dirs \
  && echo "file:///prints prints" >> /home/slic3r/.gtk-bookmarks  \
  && chown -R 33:33 /slic3r/ /home/slic3r/ /prints/ /configs/

COPY ./apps/prusaslicer-novnc/config/prusaslicer.conf /etc/supervisord.d/