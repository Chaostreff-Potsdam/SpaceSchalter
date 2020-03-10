wifi.setmode(wifi.STATION, true)
wifi.setcountry({country="DE", start_ch=1, end_ch=13, policy=wifi.COUNTRY_AUTO})
wifipar = require("eus_params")
station_cfg={}
station_cfg.ssid=wifipar.wifi_ssid
station_cfg.pwd=wifipar.wifi_password
station_cfg.save=true
wifi.sta.config(station_cfg)
wifi.sta.autoconnect(1)
