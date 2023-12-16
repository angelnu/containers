FROM --platform=$TARGETPLATFORM ghcr.io/onedr0p/ubuntu:rolling@sha256:e92fa6e1d70f727d1b4232b93ec1c135fbafb5decbfac8ea3d0565b30a8a3c71

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG VERSION
ARG CHANNEL
ARG TARGETARCH

USER root

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
