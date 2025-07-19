FROM --platform=$TARGETPLATFORM docker.io/ubuntu:rolling@sha256:95a416ad2446813278ec13b7efdeb551190c94e12028707dd7525632d3cec0d1
ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG VERSION
ARG CHANNEL
ARG TARGETARCH

# renovate: datasource=github-releases depName=angelnu/TTRSS-Auth-LDAP
ARG VERSION_LDAP_AUTH=v3.0.0

# hadolint ignore=DL3002
USER root

WORKDIR /app

# hadolint ignore=DL3008,DL3015,SC2086
RUN \
  export EXTRA_INSTALL_ARG="git" \
  && cd /app \
  && apt-get -qq update \
  && \
  apt-get -qq install -y \
    php-fpm \
    php-pdo php-gd php-pgsql php-pgsql php-mbstring \
	  php-intl php-xml php-curl php-ldap \
	  php-dom php-fileinfo php-json php-iconv \
	  php-zip \
	  postgresql-client sudo php-xdebug \
    nginx \
    ca-certificates \
    ${EXTRA_INSTALL_ARG} \
  && git config --global --add safe.directory /app \
  && git clone https://git.tt-rss.org/fox/tt-rss.git . \
  && if [ -n "$VERSION" ]; then \
    NUMBER_COMMITS_TO_REVERT=$(( $(git rev-list --count --first-parent HEAD) - $(echo $VERSION|cut -d "." -f3) )); \
    git checkout "master~$NUMBER_COMMITS_TO_REVERT"; \
  fi \
  && git clone https://git.tt-rss.org/fox/ttrss-nginx-xaccel.git plugins.local/nginx_xaccel \
  && git clone -b $VERSION_LDAP_AUTH https://github.com/angelnu/TTRSS-Auth-LDAP.git plugins.local/auth_ldap \
  && git clone https://github.com/HenryQW/mercury_fulltext.git plugins.local/mercury_fulltext \
  && chown -R www-data:www-data . .git cache feed-icons lock \
  && cp -a config.php-dist config.php \
  && sed -i.bak 's/\(memory_limit =\) 128M/\1 256M/' /etc/php/*/fpm/php.ini \
  && sed -i.bak -e 's/;clear_env = .*/clear_env = no/i' -e 's/php8.1-fpm.sock/php-fpm.sock/i' /etc/php/*/fpm/pool.d/www.conf \
  && echo apt-get remove -y ${EXTRA_INSTALL_ARG} \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && apt-get autoremove -y \
  && apt-get clean \
  && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/

#USER kah
#nginx and php use www-data as non-privileged user
#this container does not need to write persistent files - it only persists to DB

WORKDIR /config

EXPOSE 8080

COPY ./apps/tt-rss/nginx.conf /etc/nginx/sites-enabled/default
COPY ./apps/tt-rss/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]
