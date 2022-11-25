FROM --platform=$TARGETPLATFORM ghcr.io/onedr0p/alpine:rolling@sha256:8e1eb13c3ca5c038f3bf22a5fe9e354867f97f98a78027c44b7c76fce81fa61d

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