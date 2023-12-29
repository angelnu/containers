#!/usr/bin/env bash

version="$(curl -sX GET "https://api.github.com/repos/prusa3d/PrusaSlicer/releases/latest" | jq --raw-output '.tag_name')"
version="${version#*version_}"
printf "%s" "${version}"