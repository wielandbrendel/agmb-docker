#!/usr/bin/env bash

# Build OpenBLAS and clean up build dependencies
set -xe

mkdir /tmp/build
cd /tmp/build
git config --global url.https://github.com/.insteadOf git://github.com/

git clone -q https://github.com/numpy/numpy.git
cp /tmp/numpy-site.cfg numpy/site.cfg

git clone -q https://github.com/scipy/scipy.git
cp /tmp/scipy-site.cfg scipy/site.cfg

apt-get update
apt-get build-dep -y python3 python3-numpy python3-scipy python3-matplotlib cython3 python3-h5py
curl https://bootstrap.pypa.io/get-pip.py | python2

PYTHON="python2"
PIP="pip2"

apt-get -y remove cython 
# apt-get -y remove numpy
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
$PIP install bokeh

# Install additional developer tools
$PIP install mock
$PIP install pytest
$PIP install 
cd /
