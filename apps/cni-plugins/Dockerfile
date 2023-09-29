FROM --platform=$TARGETPLATFORM ghcr.io/onedr0p/alpine:rolling@sha256:a45f246424c791487a44ba5cbe5720ae5318813dce3924c0e04d943e0fd0996d

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