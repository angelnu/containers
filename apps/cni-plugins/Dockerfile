FROM --platform=$TARGETPLATFORM ghcr.io/onedr0p/alpine:rolling@sha256:022108430d7b563b86731c2ab9e5f1f07a8e2520024314c446117e20729dba47

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