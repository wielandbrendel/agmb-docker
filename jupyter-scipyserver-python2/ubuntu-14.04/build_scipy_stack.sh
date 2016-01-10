#!/usr/bin/env bash

# Build OpenBLAS and clean up build dependencies
set -xe

mkdir /tmp/build
cd /tmp/build

apt-get -y update
apt-get -y install gfortran

# Build latest stable release from OpenBLAS from source
git clone -q --branch=master https://github.com/xianyi/OpenBLAS.git
(cd OpenBLAS \
      && make DYNAMIC_ARCH=1 NO_AFFINITY=1 NUM_THREADS=32 \
          && make install  DYNAMIC_ARCH=1 NO_AFFINITY=1 NUM_THREADS=32)

# Rebuild ld cache, this assumes that:
# /etc/ld.so.conf.d/openblas.conf was installed by Dockerfile
# and that the libraries are in /opt/OpenBLAS/lib
ldconfig

git clone -q https://github.com/numpy/numpy.git
cp /tmp/numpy-site.cfg numpy/site.cfg

git clone -q https://github.com/scipy/scipy.git
cp /tmp/scipy-site.cfg scipy/site.cfg

apt-get build-dep -y python3 python3-numpy python3-scipy python3-matplotlib cython3 python3-h5py
curl https://bootstrap.pypa.io/get-pip.py | python2

PYTHON="python2"
PIP="pip2"

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
