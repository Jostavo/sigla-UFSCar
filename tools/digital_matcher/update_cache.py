import requests
import json
r = requests.post("https://siglaufscar.herokuapp.com/dashboard/access/fingerprint/get/all", data={"laboratory_id":2})
fingerPrints = json.loads(r.text)
cache = open("cache", "w")
for i in fingerPrints:
    cache.write(str(i["user_id"]) + "|" + i["biometric"].replace(" ", "+") + "\n")
cache.close()
