# This program reads in responses for our 16PF dataset

import numpy as np

def read_16pf_as_ndarray():
    return np.genfromtxt('../data/16pf.csv', dtype=float, skip_header=1, usecols=range(163))