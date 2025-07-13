'''
CWV: Check the distribution of random numbers.
'''
import pandas as pd
import matplotlib.pyplot as plt

CSV_PATH = "./outputs/cw3.csv"
PLOT_PATH = "./plots/ran1_ran2_dist.png"

def plot_distribution(ran1, ran2, plot_path):
    df = pd.read_csv(CSV_PATH)
    plt.subplot(1, 2, 1)
    plt.hist(ran1)
    plt.title(f"ran1 Distribution")
    
    plt.subplot(1, 2, 2)
    plt.hist(ran2)
    plt.title(f"ran2 Distribution")

    plt.savefig(plot_path)


if __name__ == "__main__":
    df = pd.read_csv(CSV_PATH)
    plot_distribution(df["ran1"], df["ran2"], PLOT_PATH)
