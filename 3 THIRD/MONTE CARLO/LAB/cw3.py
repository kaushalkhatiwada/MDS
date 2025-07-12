'''
CWIII: Now convert ran1 and ran2 to lie in the range of (0,1).
'''
import pandas as pd

CSV_PATH = "./outputs/cw2.csv"
OUT_PATH = "./outputs/cw3.csv"
N_MAX = (2**31-1)
def read_csv_convert_to_range(csv_path):
    global N_MAX
    df = pd.read_csv(csv_path)
    df["ran1"] = df["ran1"] / N_MAX
    df["ran2"] = df["ran2"] / N_MAX
    return df

def save_to_csv(df):
    global OUT_PATH
    df.to_csv(OUT_PATH, index=False)
    print("Saved Successfully!")

if __name__ == "__main__":
    df = read_csv_convert_to_range(CSV_PATH)
    save_to_csv(df)
