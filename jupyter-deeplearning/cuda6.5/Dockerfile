FROM wielandbrendel/jupyter-scipyserver:cuda6.5

MAINTAINER Wieland Brendel <wieland.brendel@posteo.de>

# Install Caffe
# -------------

RUN apt-get install wget

RUN CUDA_REPO_PKG=cuda-repo-ubuntu1404_7.5-18_amd64.deb && \
    wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/$CUDA_REPO_PKG && \
    sudo dpkg -i $CUDA_REPO_PKG

RUN ML_REPO_PKG=nvidia-machine-learning-repo_4.0-2_amd64.deb && \
    wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1404/x86_64/$ML_REPO_PKG && \
    sudo dpkg -i $ML_REPO_PKG

ENV CAFFE_VERSION 0.14
LABEL com.nvidia.caffe.version="0.14"

ENV CAFFE_PKG_VERSION 0.14.0~rc.3-1
RUN apt-get update && apt-get install -y --no-install-recommends --force-yes \
            caffe-nv=$CAFFE_PKG_VERSION \
            caffe-nv-tools=$CAFFE_PKG_VERSION \
            python-caffe-nv=$CAFFE_PKG_VERSION && \
    rm -rf /var/lib/apt/lists/*

ADD requirements.txt /tmp/requirements.txt
RUN pip2 install -r /tmp/requirements.txt

# Install Torch
# -------------

RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -yq \
  torch7-nv

# Install iTorch
# --------------

RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -yq \
  libzmq3-dev \
  libssl-dev \
  python-zmq \
  cmake

RUN git clone https://github.com/facebook/iTorch.git ~/itorch
RUN cd ~/itorch && luarocks make

# Install loadcaffe
RUN CC="gcc-4.8" CXX="g++-4.8" luarocks install loadcaffe

