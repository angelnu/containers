FROM --platform=$TARGETPLATFORM ghcr.io/onedr0p/alpine:rolling@sha256:0e3067295cc20dafbd4cf63789ccc71858ad555f3998200ca10b271328c7285e

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG VERSION
ARG CHANNEL
ARG TARGETARCH

USER root
ADD https://github.com/containernetworking/plugins/releases/download/v${VERSION}/cni-plugins-linux-${TARGETARCH}-v${VERSION}.tgz /
RUN mkdir /plugins && \
      tar -zxvf /*.tgz -C /plugins && \
      rm /*.tgz
CMD cp -n /plugins/* /host/opt/cni/bin
