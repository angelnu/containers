FROM --platform=$TARGETPLATFORM docker.io/ubuntu:rolling@sha256:1c2a84ae3f2a24aeb97cded5b41f0211b441662f1a188cbd2e139e7625f6f1d6

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG VERSION
ARG CHANNEL
ARG TARGETARCH

RUN apt update \
    && apt-get install -y apache2 ssl-cert libapache2-mod-musicindex \
    && apt-get -y clean all \
    && mkdir -p /music /cache \
    && chown -R kah:kah /music /cache \
    && a2enmod ssl musicindex \
    && a2ensite default-ssl \
    && rm -rf /var/www/html \
    && ln -s /music /var/www/html

COPY ./apps/apache-musicindex/config/musicindex.conf /etc/apache2/conf-enabled/
COPY ./apps/apache-musicindex/entrypoint.sh /entrypoint.sh

WORKDIR /music

EXPOSE 80 443

CMD ["/entrypoint.sh"]
