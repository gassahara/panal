import pycurl
import certifi
import json
from io import BytesIO

buffer = BytesIO()
c = pycurl.Curl()
c.setopt(pycurl.HTTPHEADER, ['X-MBX-APIKEY: APIKEY'])
c.setopt(pycurl.HTTPGET, 1)
c.setopt(c.URL, 'https://vapi.binance.com/api/v1/klines?symbol=BTCTUSD&interval=5m')
c.setopt(pycurl.FOLLOWLOCATION, True)
c.setopt(pycurl.FOLLOWLOCATION, 1)
c.setopt(c.WRITEDATA, buffer)
c.setopt(pycurl.SSL_VERIFYPEER, 0)
c.setopt(pycurl.SSL_VERIFYHOST, 0)
c.setopt(c.CAINFO, certifi.where())
c.perform()
c.close()


body = buffer.getvalue()
# Body is a byte string.
# We have to know the encoding in order to print it to a text file
# such as standard output.
jsonO = json.loads(body.decode('iso-8859-1'))
#print(body.decode('iso-8859-1'))
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
    print(str(rs))
    y=y+1
    

