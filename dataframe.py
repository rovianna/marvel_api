from network import requestMarvelAPI
from character import defineCharacterFields
import pandas as pd

characters_arr = []

for characters in requestMarvelAPI():
    characters_arr.append(defineCharacterFields(characters))

dataframe = pd.DataFrame(characters_arr)

print(dataframe)