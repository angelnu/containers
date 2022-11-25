FROM --platform=$TARGETPLATFORM ghcr.io/onedr0p/alpine:rolling@sha256:4aa9bf81b468ac839a40e4916e0705f087472bcc5eb027d008b81543ab984f8c

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