#!/usr/bin/env bash

# renovate: datasource=docker depName=ubuntu versioning=docker
ubuntu_version="24.04"

version="$(curl https://ppa.launchpadcontent.net/kicad/kicad-7.0-releases/ubuntu/pool/main/k/kicad/|sed -nr 's/.*kicad_(.*)~.*'${ubuntu_version}'.*/\1/p'|tail -n1)"
printf "%s" "${version}"