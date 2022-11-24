FROM --platform=$TARGETPLATFORM ghcr.io/onedr0p/alpine:rolling@sha256:236a079145da5ce82269346534cacc8483ddaa8ff1aa4feaaf3a1bf6fb4d1cda

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