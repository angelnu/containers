FROM --platform=$TARGETPLATFORM ghcr.io/onedr0p/alpine:rolling@sha256:23ca8ffcdfbe16492f0d638b71691985b15b3aa7cc373f366a14ec17275bc584

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