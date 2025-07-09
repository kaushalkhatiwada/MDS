'''
CWI: Write an algorithm to open a file and write above random
numbers in that file.
'''

''''
Algorithms:
- Initialize C, TOTAL_NUM, count=0, Nmax, random_list
- Input large number called seed
- While Count is less than TOTAL_NUM
    - compute random number using formulae: ran = (C * seed) MOD Nmax
    - set new ran to seed
    - append ran to random_list
- stop the process.
'''
import pandas as pd

C = 16807
TOTAL_NUM = 1000
OUT_PATH = "./outputs/cw1.csv"
seed = 12345

def congruential_random_generator(seed, total_num, c):
    count = 0
    n_max = (2**31-1)
    random_list = []
    while count < total_num:
        ran = (16807 * seed) % n_max
        seed = ran
        count += 1
        random_list.append(ran)
    
    return random_list

def save_to_csv(random_num_list):
    global OUT_PATH
    df = pd.DataFrame({"random_num": random_num_list})
    df.to_csv(OUT_PATH, index=False)
    print("Saved Successfully!")



if __name__ == '__main__':
    random_list = congruential_random_generator(seed, TOTAL_NUM, C)
    save_to_csv(random_list)
