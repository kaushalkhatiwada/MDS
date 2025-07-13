'''
CWIV: Plot ran2 vs ran1.
'''
import pandas as pd
import matplotlib.pyplot as plt

CSV_PATH = "./outputs/cw3.csv"
PLOT_PATH = "./plots/ran2_vs_ran1.png"

def plot_scatter():
    df = pd.read_csv(CSV_PATH)
    plt.scatter(df["ran1"], df["ran2"])
    plt.xlabel("ran1")
    plt.ylabel("ran2")
    plt.title("ran2 vs ran1")
    plt.savefig(PLOT_PATH)


if __name__ == "__main__":
    plot_scatter()

