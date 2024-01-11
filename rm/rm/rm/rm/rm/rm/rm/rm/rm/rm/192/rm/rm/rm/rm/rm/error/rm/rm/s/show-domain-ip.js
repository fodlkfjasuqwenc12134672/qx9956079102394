function dnsRequestHandler(request) {
    let domainsToLog = ['binance.com'];
    if (domainsToLog.includes(request.hostname)) {
        let message = `已連接到 ${request.hostname}, IP: ${request.ip}`;
        $notification.post('網絡連接通知', request.hostname, message);
    }
    return null;
}

surge.setDnsRequestHandler(dnsRequestHandler);
