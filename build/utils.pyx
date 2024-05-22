import numpy as np
cimport numpy as np
import math

def new_map(double x, double y, double a=0.115, double b=0.564):
    x1 = x**3 + y*x + 2 * a * b
    y1 = (x + y) ** 0.5 + y * 2
    x1 = 4 * x1 * math.sin(1-x1)
    y1 = 4 * y1 * math.cos(1-y1)
    return x1 % 1, y1 % 1

def new_map_arr(np.ndarray x, np.ndarray y, np.ndarray a, np.ndarray b):
    x1 = x**3 + y*x + 2 * a * b
    y1 = (x + y) ** 0.5 + y * 2
    x1 = 4 * x1 * np.sin(1-x1)
    y1 = 4 * y1 * np.cos(1-y1)
    return x1 % 1, y1 % 1

def generate_prns(np.ndarray params, length, k=32):
    cdef np.ndarray arr
    cdef int count

    count = 0
    for i in range(k):
        params[count-1], params[count] = new_map(params[count-1], params[count])
        count = (count + 1) % params.size

    count = 0
    arr = np.zeros(length+2)
    for i in range(0, length, 2):
        params[count], params[count-1] = new_map(params[count-1], params[count])   
        arr[i], arr[i+1] = params[count-1], params[count]
        count = (count + 1) % params.size
    return arr[:length]

def sequence(np.ndarray params, length, k=20):
    cdef np.ndarray arr
    arr = np.zeros(length)
    for i in range(k):
        params[0], params[1] = new_map(params[0], params[1])

    count = 0
    for i in range(0, length, 2):
        params[0], params[1] = new_map(params[0], params[1])   
        arr[i], arr[i+1] = params[0], params[1]
    return arr
