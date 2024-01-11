function dnsRequestHandler(request) {
    if (request.hostname.endsWith('binance.com')) {
        let message = `已連接到 ${request.hostname}, IP: ${request.ip}`;
        console.log(message);  // 將信息記錄到日誌中
        $notification.post('網絡連接通知', request.hostname, message);  // 在App中彈出通知
    }
    return null;
}

surge.setDnsRequestHandler(dnsRequestHandler);
