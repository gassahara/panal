import pycurl
import certifi
import json
import time
import hmac
import hashlib
from datetime import datetime
from io import BytesIO


archivo="binance.key"
with open(archivo) as f:
    for line in f:
        rec = line.strip().split(';')
        print(rec)
        apikey=rec[2]
        secretKey=bytearray((rec[1]).encode("utf-8"))
        user=rec[0]
        #apikey='FACtYR7FyxULjDCqaqF4e0bx8htmNvKMmjZ9QlN9Ac39rXaBWTeFLQSkv6oQ0YRg'
        #secretKey=bytearray( ('9VDaJwg0zhTfRKTnS8oLFNoyitSdPide0AMfcIB3ym8r92fd08N6CmlqqzCjUy6v').encode("utf-8"))
        #user="gassahara"
        symbols=["BTCUSDT", "ETHBTC", "ETCETH"]
        l=len(symbols)
        i=0
        f = open("Binance_History_" + user, "w")
        print(apikey)
        print("FECHA;HORA;PAR;CANTIDAD;TIPO;PRECIO;Id_Orden;")
        f.write("FECHA;HORA;PAR;CANTIDAD;TIPO;PRECIO;Id_Orden;\n")
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
#            URL="https://api.binance.com/api/v3/allOrders?"+data
            URL='https://vapi.binance.com/api/v1/klines?symbol=' + symbols[i] + '&interval=5m'
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

            f = open(symbols[i] + "RSI", "w")
            f.write("")
            f.close()
            f = open(symbols[i] + "RS", "w")
            f.write("")
            f.close()

            body=""
            body = buffer.getvalue()
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
                f = open(symbols[i] + "RSI", "a")
                f.write(str(rsi)+'\n')
                f.close()
                f = open(symbols[i] + "RS", "a")
                f.write(str(rs)+'\n')
                f.close()
                print(str(rs))
                y=y+1
            i=i+1
        time.sleep(60)
            
