#!/bin/bash

# Function to install hy2
install_hy2() {
  echo "正在安裝 hy2..."
  bash <(curl -fsSL https://get.hy2.sh/)

  echo "請輸入您要使用的端口（默認為443）："
  read -r port
  if [[ -z "$port" ]]; then
    port=443
  fi

  # 生成自簽證書
  echo "生成自簽證書..."
  openssl ecparam -genkey -name prime256v1 -out /etc/hysteria/private.key
  openssl req -new -x509 -days 3650 -key /etc/hysteria/private.key -out /etc/hysteria/cert.crt -subj "/CN=www.douyin.com"

  # 设置文件权限
  chmod 644 /etc/hysteria/private.key
  chmod 644 /etc/hysteria/cert.crt

  # 删除旧的配置文件
  rm -f /etc/hysteria/config.yaml

  # 写入新的配置文件
  echo "寫入配置文件..."
  cat <<EOF > /etc/hysteria/config.yaml
listen: :$port

tls:
  cert: /etc/hysteria/cert.crt
  key: /etc/hysteria/private.key

auth:
  type: password
  password: j90p90

masquerade:
  type: proxy
  proxy:
    url: https://www.icloud.com/us
    rewriteHost: true
  listenHTTP: :80
  listenHTTPS: :443
  forceHTTPS: true

quic:
  initStreamReceiveWindow: 33554432
  maxStreamReceiveWindow: 33554432
  initConnReceiveWindow: 83886080
  maxConnReceiveWindow: 83886080
  maxIdleTimeout: 30s
  maxIncomingStreams: 1024
  disablePathMTUDiscovery: false
EOF

  # 重载系统守护进程并重启服务
  systemctl daemon-reload
  systemctl restart hysteria-server.service

  # 检查服务状态
  systemctl status hysteria-server.service

  # 输出连接信息
  echo "hy2 安装完成。请使用以下信息连接："
  echo "hy2://$(curl -s ifconfig.me):$port"
}

# Function to change port
change_port() {
  echo "請輸入新的端口："
  read -r new_port
  if [[ -z "$new_port" ]]; then
    echo "端口不能為空"
    exit 1
  fi

  sed -i "s/^listen: :.*$/listen: :$new_port/" /etc/hysteria/config.yaml
  systemctl daemon-reload
  systemctl restart hysteria-server.service
  systemctl status hysteria-server.service
  echo "端口已更改為 $new_port"
}

# Function to view status
view_status() {
  systemctl status hysteria-server.service
}

# Function to start hy2
start_hy2() {
  systemctl start hysteria-server.service
  systemctl status hysteria-server.service
}

# Function to stop hy2
stop_hy2() {
  systemctl stop hysteria-server.service
}

# Function to restart hy2
restart_hy2() {
  systemctl restart hysteria-server.service
  systemctl status hysteria-server.service
}

# Function to completely remove hy2
remove_hy2() {
  echo "正在移除 hy2..."
  bash <(curl -fsSL https://get.hy2.sh/) --remove
  rm -f /etc/hysteria/config.yaml
  rm -f /etc/hysteria/private.key /etc/hysteria/cert.crt
  echo "hy2 已被移除。"
}

# Menu options
echo "請選擇一個選項："
echo "1. 安裝 hy2"
echo "2. 更改端口"
echo "3. 查看狀態"
echo "4. 啟動 hy2"
echo "5. 停止 hy2"
echo "6. 重啟 hy2"
echo "7. 完整移除 hy2"

read -r choice

case $choice in
  1)
    install_hy2
    ;;
  2)
    change_port
    ;;
  3)
    view_status
    ;;
  4)
    start_hy2
    ;;
  5)
    stop_hy2
    ;;
  6)
    restart_hy2
    ;;
  7)
    remove_hy2
    ;;
  *)
    echo "无效选项"
    ;;
esac
