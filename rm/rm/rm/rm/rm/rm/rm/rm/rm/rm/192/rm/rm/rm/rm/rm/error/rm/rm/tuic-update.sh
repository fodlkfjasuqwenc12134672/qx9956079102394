#!/bin/bash
chmod +x tuic-update.sh

blue(){ echo -e "\033[36m\033[01m$1\033[0m";}
red(){ echo -e "\033[31m\033[01m$1\033[0m";}
green(){ echo -e "\033[32m\033[01m$1\033[0m";}
yellow(){ echo -e "\033[33m\033[01m$1\033[0m";}
white(){ echo -e "\033[37m\033[01m$1\033[0m";}


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
systemctl status tuic

version=$(curl -s https://api.github.com/repos/EAimTY/tuic/releases/latest | grep "tag_name" | grep -v "sha256" | grep -v "github" | cut -d : -f 2,3)
echo ""
# echo "TUIC版本成功更新至：${version}"
white "TUIC版本成功更新至：${version}"












# echo "curl -s https://api.github.com/repos/EAimTY/tuic/releases/latest \
# | grep "tag_name" \
# | grep -v "sha256" \
# | grep -v "github" \
# | cut -d : -f 2,3"


# curl -s https://api.github.com/repos/EAimTY/tuic/releases/latest \
# | grep "tag_name" \
# | grep -v "sha256" \
# | grep -v "github" \
# | cut -d : -f 2,3 \
# | tr -d \" \
# | wget -qi - -O /usr/local/bin/tuic

