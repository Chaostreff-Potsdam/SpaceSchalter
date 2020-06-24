
import logging
logging.basicConfig(level=logging.DEBUG)

# If you want to use a specific client id, use
# mqttc = mqtt.Client("client-id")
# but note that the client id must be unique on the broker. Leaving the client
# id parameter empty will generate a random id for you.
mqttc = mqtt.Client()

def messageReceived(client, userdata, message):
  print("received topic" + str(message.topic) + "with payload:" + str(message.payload)) 

mqttc.username_pw_set("user","pass")

mqttc.on_message = messageReceived
mqttc.connect("ccc-p.org", 1883, 60)
mqttc.subscribe("/sensors/spaceschalter/status", 0)

mqttc.loop_forever()
