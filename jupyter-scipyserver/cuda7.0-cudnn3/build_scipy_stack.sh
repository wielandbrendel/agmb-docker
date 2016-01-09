#!/usr/bin/env bash

# System dependencies
apt-get build-dep -y python3 python3-numpy python3-scipy python3-matplotlib cython3 python3-h5py
curl https://bootstrap.pypa.io/get-pip.py | python3

PYTHON="python3"
PIP="pip3"

$PIP install --upgrade cython

# Build NumPy and SciPy from source against OpenBLAS installed
(cd numpy && $PIP install .)
(cd scipy && $PIP install .)
  
# The rest of the SciPy Stack
$PIP install pandas scikit-learn
$PIP install matplotlib
$PIP install seaborn
$PIP install h5py
$PIP install yt
$PIP install sympy
$PIP install patsy
$PIP install ggplot
$PIP install statsmodels
$PIP install git+https://github.com/Theano/Theano.git 
$PIP install git+https://github.com/Lasagne/Lasagne.git
cd /
rm -rf /tmp/build
