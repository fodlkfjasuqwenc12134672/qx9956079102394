var matchedHostnames = ['binance.com', 'www.binance.com'];
var hostnameMatched = matchedHostnames.includes($request.hostname);

function fetchCountry() {
    var options = {
        url: "https://www.binance.com/bapi/accounts/v2/public/account/ip/country-city-short",
        timeout: 5 
    };

    $httpClient.get(options, function(error, response, data){
        if (error) {
            console.log("请求错误: " + error);
            $done();
        } else {
            try {
                var result = JSON.parse(data);
                var country = result.data.country;
                $notification.post("Domain: " + $request.hostname, "Region: " + country, "");
            } catch (e) {
                console.log("解析错误: " + e);
            }
            $done();
        }
    });
}

if (hostnameMatched) {
    fetchCountry();
} else {
    $done({matched: hostnameMatched});
}

