print("start init wifi")
wifi.setmode(wifi.STATION, true)
wifi.setcountry({country="DE", start_ch=1, end_ch=13, policy=wifi.COUNTRY_AUTO})
param = require("eus_params")
station_cfg={}
station_cfg.ssid=param.wifi_ssid
station_cfg.pwd=param.wifi_password
station_cfg.save=true
wifi.sta.config(station_cfg)
 

