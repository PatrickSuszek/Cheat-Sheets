#!/usr/bin/env bash

set -e

mkdir -p forgejo-runner/.cache
mkdir docs-sites

chown -R 1001:1001 forgejo-runner
chmod 775 forgejo-runner/.cache
chmod g+s forgejo-runner/.cache

sudo cp runner-config.yml /forgejo-runner/config.yml