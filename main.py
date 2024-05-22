from utils import generate_prns, sequence
import time
import numpy as np
import matplotlib.pyplot as plt
from nistrng import pack_sequence

if __name__ == "__main__":
    key = np.random.randint(0, 2**32, 8, dtype=np.uint32) / (2**32)
    # key = np.zeros(8)
    start = time.perf_counter()
    arr = generate_prns(key, 1000)
    print(f"Done: {time.perf_counter() - start}")

    start = time.perf_counter()
    arr2 = sequence(key, 1000)
    print(f"Done: {time.perf_counter() - start}")
    print(arr2)

    arr = (arr * (2**32)).astype(np.uint32).view(np.uint8)
    arr = pack_sequence(arr).astype(str)
    with open("randomness.txt", "w") as f:
        f.write("".join(arr))

    arr2 = (arr2 * (2**32)).astype(np.uint32).view(np.uint8)
    print(arr2)
    arr2 = pack_sequence(arr2).astype(str)
    with open("randomness2.txt", "w") as f:
        f.write("".join(arr2))
