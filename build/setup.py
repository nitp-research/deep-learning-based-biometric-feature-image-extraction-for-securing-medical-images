from Cython.Build import cythonize
from setuptools import setup
import numpy as np

setup(
    ext_modules=[cythonize('utils.pyx')],
    include_dirs=[np.get_include()]
)
