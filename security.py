import os
import hashlib
import time
from dotenv import load_dotenv

load_dotenv()

md5_hashlib = hashlib.md5()

PUBLIC_API_KEY = os.getenv("public_key")
PRIVATE_API_KEY = os.getenv("private_key")

timestamp = str(time.time())
timestamp_bytes = bytes(timestamp, "utf-8")

md5_hashlib.update(timestamp_bytes)
md5_hashlib.update(bytes(PRIVATE_API_KEY, "utf-8"))
md5_hashlib.update(bytes(PUBLIC_API_KEY, "utf-8"))


hashed_value = md5_hashlib.hexdigest()

query_keys = {'PUBLIC_KEY': PUBLIC_API_KEY, 
'TIMESTAMP': timestamp_bytes,
'HASHED': hashed_value}