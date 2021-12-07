import hashlib
import time
import requests

m = hashlib.md5()

base_url = "https://gateway.marvel.com"
query = "/v1/public/characters" + "?"

ts = str(time.time())
ts_byte = bytes(ts, 'utf-8')

m.update(ts_byte)

public_key = '7d25dee031cf5f3b0d95796877799204'
private_key = '6454306651e49dc8ac6976e556839e94092af934'

m.update(b"6454306651e49dc8ac6976e556839e94092af934")
m.update(b"7d25dee031cf5f3b0d95796877799204")

hasht = m.hexdigest()

api_url = base_url + query + "ts=" + ts + "&apikey=" + public_key + "&hash=" + hasht
print(api_url)

data = requests.get(api_url).json()
print(data)