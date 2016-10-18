import httplib, urllib
import os,sys
import time
import threading

if not os.getegid() == 0:
    sys.exit('This script must be run as root')

from pyA20.gpio import gpio
from pyA20.gpio import port
from pyA20.gpio import connector

laboratory_id = 57
laboratory_tag = 'LSO'

led = port.PA6
button = port.PA20

gpio.init()
gpio.setcfg(led, gpio.OUTPUT)
gpio.setcfg(button, gpio.INPUT)

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
        conn = httplib.HTTPConnection("siglaufscar.herokuapp.com")
        conn.request("POST", "/status", params, headers)
        response = conn.getresponse()
        condition.wait()
    condition.release()

def checkCondition(condition):
    global isOpen
    cron = time.time()
    state = -1
    while True:
        try:
            state_aux = gpio.input(button)
        except:
            print "deu algum erro..."
        timeNow = time.time()
        if (state != state_aux) | ((timeNow - cron) >= 300):
            condition.acquire()

            gpio.output(led, state)
            if(state_aux == 1):
              isOpen = False
            else:
              isOpen = True

            state = state_aux
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
