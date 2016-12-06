import httplib, urllib
import sys
import time

while True:
    params = urllib.urlencode({'computer_id':sys.argv[1:][0], 'status': "available"})
    headers = {"Content-type": "application/x-www-form-urlencoded","Accept": "text/plain"}
    conn = httplib.HTTPSConnection("siglaufscar.herokuapp.com")
    conn.request("POST", "/LSO/status", params, headers)
    response = conn.getresponse()
    time.sleep(300)
