'''
CWII: Now write two random numbers in the file at a time (say ran1
and ran2)
'''

import pandas as pd

C = 16807
TOTAL_NUM = 100
OUT_PATH = "./outputs/cw2.csv"
seed1 = 12345
seed2 = 56789

def congruential_random_generator(seed1, seed2, total_num, c):
    count = 0
    n_max = (2**31-1)
    random_list1 = []
    random_list2 = []
    while count < total_num:
        ran1 = (16807 * seed1) % n_max
        ran2 = (16807 * seed2) % n_max
        seed1 = ran1
        seed2 = ran2

        random_list1.append(ran1)
        random_list2.append(ran2)
        count += 1

    df_random = pd.DataFrame({"ran1": random_list1, "ran2": random_list2})    
    return df_random

def save_to_csv(df):
    global OUT_PATH
    df.to_csv(OUT_PATH, index=False)
    print("Saved Successfully!")

if __name__ == '__main__':
    df_random = congruential_random_generator(seed1, seed2, TOTAL_NUM, C)
    save_to_csv(df_random)
