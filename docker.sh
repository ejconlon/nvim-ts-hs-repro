#!/usr/bin/env sh
set -eu

docker build -t nvim-ts-hs-repro .
docker run --rm nvim-ts-hs-repro
