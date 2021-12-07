import os
import requests
from dotenv import load_dotenv
from security import query_keys

def requestMarvelAPI(marvel_path = "/v1/public/characters"):
    base_url = os.getenv("base_url")
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
            for character in body['results']:
                characters.append(character)
            offset = offset_min + body['limit']
            if offset >= body['total']:
                has_characters_remaining = False
        except:
            break
    return characters            