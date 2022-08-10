import pycurl
import certifi
import json
import time
from io import BytesIO

par="ETHTUSD"
URL='https://vapi.binance.com/api/v1/klines?symbol=' + par + '&interval=5m'
while 1:
    buffer = BytesIO()
    c = pycurl.Curl()
    c.setopt(pycurl.HTTPHEADER, ['X-MBX-APIKEY: APIKEY'])
    c.setopt(pycurl.HTTPGET, 1)
    c.setopt(c.URL, URL)
    c.setopt(pycurl.FOLLOWLOCATION, True)
    c.setopt(pycurl.FOLLOWLOCATION, 1)
    c.setopt(c.WRITEDATA, buffer)
    c.setopt(pycurl.SSL_VERIFYPEER, 0)
    c.setopt(pycurl.SSL_VERIFYHOST, 0)
    c.setopt(c.CAINFO, certifi.where())
    c.perform()
    c.close()
    f = open(par + "RSI", "w")
    f.write("")
    f.close()
    f = open(par + "RS", "w")
    f.write("")
    f.close()
    body=""
    body = buffer.getvalue()
    print(URL)
    # Body is a byte string.
    # We have to know the encoding in order to print it to a text file
    # such as standard output.
    jsonO=""
    try:
        jsonO = json.loads(body.decode('iso-8859-1'))
    except Exception as e:
        print(e)
        continue
    x = len(jsonO)-1
    y = 1
    downs=0.0
    ups=0.0
    upsa=0.0
    downsa=0.0
    rs=0.0
    rsi=0.0
    while y < x:
        if (float(jsonO[y][1]) - float(jsonO[y-1][1])) > 0 :
            ups+=float(jsonO[y][1])-float(jsonO[y-1][1])
        else:
            downs+=float(jsonO[y-1][1]) - float(jsonO[y][1])
            upsa=ups/y
            downsa=downs/y
        if downsa > 0.0:
            rs=upsa/downsa
            rsi=100-(100/(1+rs))
        f = open(par + "RSI", "a")
        f.write(str(rsi)+'\n')
        f.close()
        f = open(par + "RS", "a")
        f.write(str(rs)+'\n')
        f.close()
        print(str(rs))
        y=y+1
    time.sleep(60)
