#!/bin/bash

#TUIC 安裝路徑/usr/local/bin/tuic
#certificate | /root/ygkkkca/cert.crt | /root/ygkkkca/private.key | 
#certificatec='/root/ygkkkca/cert.crt'
#certificatep='/root/ygkkkca/private.key'
#Server路徑 /etc/tuic/tuic.json
#client路徑 /root/tuic/v2rayn.json

systemctl stop tuic

#update tuic-server
curl -s https://api.github.com/repos/EAimTY/tuic/releases/latest \
| grep "browser_download_url.*x86_64-unknown-linux-musl" \
| grep -v "sha256" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi - -O /usr/local/bin/tuic

chmod +x /usr/local/bin/tuic
systemctl restart tuic

