-- Startup script
--
-- LICENCE: http://opensource.org/licenses/MIT


-- app = require("app")

config = require "config"

wifi.sta.connect(function()
    print("................")
    print("................")
    print("................")
    print("................")
    print("................")
    print("................")    
    mqfunctions = require "mqttfunctions"
end)

pin = 7

offmode = string.char(0, 255, 0,
                      0, 255, 0,
                      0, 255, 0,
                      0, 0, 0, 0, 0, 0, 0, 0, 0)
onmode = string.char( 0, 0, 0, 
                      0, 0, 0, 
                      0, 0, 0, 
                      255, 0, 0,
                      255, 0, 0,
                      255, 0, 0)

ws2812.init()

if gpio.read(pin) > 0 then
    ws2812.write(onmode)
else
    ws2812.write(offmode)
end


function debounce (func)
    local last = 0
    local delay = 50000 -- 50ms * 1000 as tmr.now() has μs resolution

    return function (...)
        local now = tmr.now()
        local delta = now - last
        if delta < 0 then delta = delta + 2147483647 end; -- proposed because of delta rolling over, https://github.com/hackhitchin/esp8266-co-uk/issues/2
        if delta < delay then return end;

        last = now
        return func(...)
    end
end

function onChange ()
    if gpio.read(pin) > 0 then
        print('Switch ON')
        ws2812.write(onmode)
        publish_status("/sensors/spaceschalter/status", "open")
    else
        print('Switch OFF')
        ws2812.write(offmode)
        publish_status("/sensors/spaceschalter/status", "closed")
    end
end

gpio.mode(pin, gpio.INT, gpio.PULLUP) -- see https://github.com/hackhitchin/esp8266-co-uk/pull/1
gpio.trig(pin, 'both', debounce(onChange))




-- lcd = require("lcd")
-- setup = require("setup")

-- setup.start()
