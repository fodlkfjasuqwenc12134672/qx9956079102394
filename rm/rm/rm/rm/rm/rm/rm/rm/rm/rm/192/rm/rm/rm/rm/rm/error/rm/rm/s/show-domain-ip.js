function dnsRequestHandler(request) {
    let domainsToLog = ['binance.com'];
    if (domainsToLog.includes(request.hostname)) {
        console.log(`已連接到 ${request.hostname}, IP: ${request.ip}`);
    }
    return null;
}

surge.setDnsRequestHandler(dnsRequestHandler);
