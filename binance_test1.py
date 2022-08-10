import pycurl
import certifi
import json
import time
import hmac
import hashlib
from datetime import datetime
from io import BytesIO

apikey='APIKEY'
secretKey=bytearray( ('APISECRETKEY').encode("utf-8"))
user="gassahara"
symbols=["BTCUSDT", "ETHBTC", "ETCETH"]
l=len(symbols)
i=0
print("FECHA;HORA;PAR;CANTIDAD;TIPO;PRECIO;Id_Orden;")
f = open("Binance_History_" + user, "w")
f.write("")
f.close()
while i < l:
    buffer = BytesIO()
    symbol=symbols[i]
    times=str(int(round(time.time() * 1000)))
    params = {
        "symbol": symbol,
        "timestamp": times,
    }
    sign = ''
    for key in sorted(params.keys()):
        v = params[key]
        if isinstance(params[key], bool):
            if params[key]:
                v = 'true'
            else :
                v = 'false'
    sign += key + '=' + v + '&'
    sign = sign[:-1]
    sign="symbol="+symbol+"&timestamp="+times
    #print(sign)
    hash = hmac.new(secretKey, bytearray(sign.encode("utf-8")), hashlib.sha256)
    signature = hash.hexdigest()
    sign_real = {
        "sign": signature
    }
    data=sign + "&signature=" + signature
    URL="https://api.binance.com/api/v3/allOrderList?"+data
    #print("URL:" + URL)
    c = pycurl.Curl()
    c.setopt(pycurl.HTTPHEADER, ['X-MBX-APIKEY: ' + apikey])
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

    body=""
    body = buffer.getvalue()
    jsonO=""
    try:
        jsonO = json.loads(body.decode('iso-8859-1'))
    except Exception as e:
        print(e)
        continue
    x = len(jsonO)
    y = 1
    while y < x:
        cad=datetime.fromtimestamp(jsonO[y]["time"]/1000).strftime('%m/%d/%Y')+";"+datetime.fromtimestamp(jsonO[y]["time"]/1000).strftime('%H:%M:%S')+";"+jsonO[y]["symbol"]+";"+str(jsonO[y]["executedQty"])+";"+jsonO[y]["side"]+";"+str(jsonO[y]["price"])+";"+str(jsonO[y]["orderId"])
        print(cad)
        f = open("Binance_History_" + user, "a")
        f.write(cad+"\n")
        f.close()
        y=y+1
    i=i+1
    time.sleep(10)
