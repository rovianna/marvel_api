from network import requestMarvelAPI
from character import defineCharacterFields
import pandas as pd

def main():
    characters_arr = []
    for characters in requestMarvelAPI():
        characters_arr.append(defineCharacterFields(characters))
        dataframe = pd.DataFrame(characters_arr)
    dataframe.to_csv('characters_dataframe.csv', encoding='utf-8')
    print("I am... inevitable...")
    print("=== DATAFRAME ===")
    print(dataframe)

if __name__ == "__main__":
    main()