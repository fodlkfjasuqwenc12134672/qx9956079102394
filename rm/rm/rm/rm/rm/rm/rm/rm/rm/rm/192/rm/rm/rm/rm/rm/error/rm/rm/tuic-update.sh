#!/bin/bash

chmod +x tuic-update.sh

#update tuic-server
curl -s https://api.github.com/repos/EAimTY/tuic/releases/latest \
| grep "browser_download_url.*x86_64-unknown-linux-musl" \
| grep -v "sha256" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi - -O /usr/local/bin/tuic

chmod +x /usr/local/bin/tuic
systemctl restart tuic
systemctl status tuic
