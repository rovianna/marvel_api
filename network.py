import os
import requests
from dotenv import load_dotenv
from security import query_keys

base_url = os.getenv("base_url")

r = requests.get(base_url)



def requestMarvelAPI(marvel_path = "/v1/public/characters"):
    has_characters_remaining = True
    characters = []
    offset = 0
    print("Thanos is collecting the stones...")
    while has_characters_remaining:
        params={"ts": query_keys.get("TIMESTAMP"), 
                "apikey": query_keys.get("PUBLIC_KEY"),
                "hash": query_keys.get("HASHED"),
                "offset": offset}
        try:
            response = requests.get(base_url + marvel_path, params=params)
            print("Fetching... " + response.url)
            body = response.json()['data']
            offset_min = body['offset']
            print(offset_min)
            characters.append(body['results'])
            offset = offset_min + body['limit']
            print(offset)
            print(body['total'])
            if offset >= body['total']:
                has_characters_remaining = False
        except:
            break
    return characters            