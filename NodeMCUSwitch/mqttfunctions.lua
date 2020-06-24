param = require("eus_params")

print("loading mqtt")
-- init mqtt client with logins, keepalive timer 120sec
m = mqtt.Client(param.mqtt_clientid, 20, param.mqtt_user, param.mqtt_pass)

-- setup Last Will and Testament (optional)
-- Broker will publish a message with qos = 0, retain = 0, data = "offline"
-- to topic "/lwt" if client don't send keepalive packet
m:lwt("/sensors/spaceschalter/status", "off", 0, 1)

m:on("connect", function(client) print ("connected") end)
m:on("offline", function(client) print ("offline") end)

m:connect(param.mqtt_host, 1883, false, function(client)
  print("connected")
  -- Calling subscribe/publish only makes sense once the connection
  -- was successfully established. You can do that either here in the
  -- 'connect' callback or you need to otherwise make sure the
  -- connection was established (e.g. tracking connection status or in
  -- m:on("connect", function)).

  -- subscribe topic with qos = 0
  client:subscribe("/sensors/spaceschalter/status", 0, function(client) print("subscribe success") end)
  m:publish("/sensors/spaceschalter/status", "on", 0, 0)

    if gpio.read(7) > 0 then
        print('Switch ON')
        m:publish("/sensors/spaceschalter/status", "open", 0, 0)
    else
        print('Switch OFF')
        m:publish("/sensors/spaceschalter/status", "closed", 0, 0)
    end
end,

function(client, reason)
  print("failed reason: " .. reason)
end)

function publish_status(topic, payload)
    m:publish(topic, payload, 0, 0)
end
