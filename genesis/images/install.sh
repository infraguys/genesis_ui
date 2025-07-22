#!/usr/bin/env bash

# Copyright 2025 Genesis Corporation
#
# All Rights Reserved.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.

set -eu
set -x
set -o pipefail

INSTALL_PATH="/opt/"
WORK_DIR="/opt/genesis_ui"
WEB_DIR="/var/www/html"
FLUTTER_SDK_PATH="/opt/flutter"
FLUTTER_SDK_VERSION=$(grep -E '^\s*flutter:' ../../pubspec.yaml | head -n1 | awk '{print $2}')

apt update
apt install -y nginx

[[ "$EUID" == 0 ]] || exec sudo -s "$0" "$@"

cd "/tmp"
wget -q "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_$FLUTTER_SDK_VERSION-stable.tar.xz"
tar -xf "flutter_linux_$FLUTTER_SDK_VERSION-stable.tar.xz" -C "$INSTALL_PATH"

ln -sv "$FLUTTER_SDK_PATH/bin/flutter" "/usr/local/bin/flutter"

cd "$WORK_DIR"

# Prepare the environment
python3 genesis/images/make_ui_build_env.py
cat env.json

# Build the application
make ci

rm -fv "$WEB_DIR/index.nginx-debian.html"
find "build/web/" -maxdepth 1 -type f -exec mv -t "$WEB_DIR/" {} +
cp -r "build/web/assets" "$WEB_DIR/"

# Configure Nginx for single page application
cp genesis/images/nginx.conf /etc/nginx/sites-available/default
