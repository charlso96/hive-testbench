import argparse
import pandas as pd

def parse_args():
    parser = argparse.ArgumentParser()
    # Required args
    parser.add_argument('-i', "--input_file")
    return parser.parse_args()

def main():
    args = parse_args()
    data = pd.read_csv(args.input_file, header = None)
    count = data[0].count()
    min = data[0].min()
    max = data[0].max()
    mean = data[0].mean()
    median = data[0].median()
    std = data[0].std()
    print('count: {}'.format(count))
    print('min: {}'.format(min))
    print('max: {}'.format(max))
    print('mean: {}'.format(mean))
    print('median: {}'.format(median))
    print('std: {}'.format(std))
    return 0

if __name__ == '__main__':
    main()