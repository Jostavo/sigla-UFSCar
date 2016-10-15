import httplib, urllib
import os
import time
import threading
#from pyA20.gpio import gpio
#from pyA20.gpio import port
#from pyA20.gpio import connector

laboratory_id = 57
laboratory_tag = 'LSO'
GPIO_INPUT = 'algma coisa'

def requestPost(condition):
    global isOpen
    condition.acquire()
    condition.wait()

    while True:
        condition.acquire()
        print "THREAD 1: mandei request..."+ str(isOpen)
        string_isOpen = str(isOpen).lower()
        params = urllib.urlencode({'laboratory_id':57, 'lab_tag':'LSO', 'isOpen': string_isOpen})
        headers = {"Content-type": "application/x-www-form-urlencoded","Accept": "text/plain"}
        conn = httplib.HTTPConnection("localhost:3000")
        conn.request("POST", "/status", params, headers)
        response = conn.getresponse()
        condition.wait()
    condition.release()

def checkCondition(condition):
    global isOpen
    cron = time.time()
    _cached_stamp = 0
    filename = '/home/floss/test.txt'
    while True:
        try:
            stamp = os.stat(filename).st_mtime
        except:
            print "deu algum erro..."
        timeNow = time.time()
        if (stamp != _cached_stamp) | ((timeNow - cron) >= 10):
            condition.acquire()

            f = open(filename, "r")
            if(f.read(1) == "1"):
                isOpen = False
            else:
                isOpen = True

            _cached_stamp = stamp
            cron = timeNow
            condition.notify()
            condition.release()

if __name__ == '__main__':
        global isOpen
        isOpen = False
        condition = threading.Condition()
        producer = threading.Thread(target=checkCondition, args=(condition,))
        consumer = threading.Thread(target=requestPost, args=(condition,))

        consumer.start()
        time.sleep(5)
        producer.start()
