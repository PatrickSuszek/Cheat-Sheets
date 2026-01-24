#!/usr/bin/env bash

set -e

mkdir -p forgejo-runner/.cache
mkdir -p docs-sites

sudo chown -R 1001:1001 forgejo-runner
sudo chmod 775 forgejo-runner/.cache
sudo chmod g+s forgejo-runner/.cache

sudo cp runner-config.yml ./forgejo-runner/config.yml