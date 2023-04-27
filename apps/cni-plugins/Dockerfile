FROM --platform=$TARGETPLATFORM ghcr.io/onedr0p/alpine:rolling@sha256:999384960b6114496a5e4036e945141c205d064ce23b87326bd3f8d878c5a9d4

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
CMD cp /plugins/* /host/opt/cni/bin