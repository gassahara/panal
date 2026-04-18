import pycurl
import certifi
import json
import time
import hmac
import hashlib
from io import BytesIO

archivo="bybit.key"
with open(archivo) as f:
    for line in f:
        rec = line.strip().split(';')
        print(rec)
        apikey=rec[2]
        secretKey=bytearray((rec[1]).encode("utf-8"))
        user=rec[0]
        #apikey='XDYrq07qGvkdSpVwuU'
        #secretKey=bytearray(('Ohi9zuQzDDLPuQfs2N3KsKErO8Dgmqa0Qecr').encode("utf-8"))
        #user="gassahara"
        pares="bybit_pares.key"
        with open(pares) as p:
            for linp in p:
                symbols = linp.strip().split(';')
                print(symbols)
                #symbols=["BTCUSD", "ETHBTC", "ETCETH"]
                l=len(symbols)
                i=0
                f = open("ByBiy_History_" + user, "w")
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
                    data=sign + "&sign=" + signature
                    URL="https://api.bybit.com/v2/private/execution/list?"+data
                    print("URL:" + URL)
                    c = pycurl.Curl()
                    c.setopt(pycurl.HTTPGET, 1)
                    c.setopt(pycurl.HTTPHEADER, ['X-MBX-APIKEY: ' + apikey])
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
                    print(body.decode('iso-8859-1'))
                    jsonO=""
                    try:
                        jsonO = json.loads(body.decode('iso-8859-1'))[1]
                    except Exception as e:
                        print(e)
                        i=i+1
                        continue
                    x = len(jsonO)
                    y = 1
                    while y < x:
                        try :
                            cad=datetime.fromtimestamp(jsonO[y]["trade_time_ms"]/1000).strftime('%m/%d/%Y')+";"+datetime.fromtimestamp(jsonO[y]["trade_time_ms"]/1000).strftime('%H:%M:%S')+";"+jsonO[y]["symbol"]+";"+str(jsonO[y]["exec_qty"])+jsonO[y]["exec_type"]+";"+str(jsonO[y]["exec_price"])+";"+str(jsonO[y]["orderId"])+";"
                            print(cad)
                            f = open("Binance_History_" + user, "a")
                            f.write(cad+"\n")
                            f.close()
                        except Exception as ex:
                            print(ex)
                            y=y+1
                    i=i+1
                    time.sleep(10)
