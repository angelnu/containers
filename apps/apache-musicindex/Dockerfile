FROM --platform=$TARGETPLATFORM docker.io/ubuntu:rolling@sha256:f3d28607ddd78734bb7f71f117f3c6706c666b8b76cbff7c9ff6e5718d46ff64

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
