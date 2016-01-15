FROM wielandbrendel/jupyter-scipyserver:cuda6.5

# Install wget and build-essential
RUN apt-get update && apt-get install -y \
  build-essential \
  wget

# Get dependencies
RUN apt-get update && apt-get install -y \
  libprotobuf-dev \
  libleveldb-dev \
  libsnappy-dev \
  libopencv-dev \
  libboost-all-dev \ 
  libhdf5-serial-dev \ 
  protobuf-compiler \ 
  gcc-4.6 \ 
  g++-4.6 \ 
  gcc-4.6-multilib \  
  g++-4.6-multilib \ 
  gfortran \ 
  libjpeg62 \ 
  libfreeimage-dev \  
  libatlas-base-dev \  
  git \ 
  python-dev \  
  python-pip \ 
  bc \ 
  wget \ 
  curl \ 
  unzip \ 
  cmake \ 
  liblmdb-dev \  
  pkgconf \
  libgtest-dev \
  valgrind

# Use gcc 4.6
RUN update-alternatives --install /usr/bin/cc cc /usr/bin/gcc-4.6 30 && \
  update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++-4.6 30 && \ 
  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.6 30 && \
  update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.6 30

RUN cd /tmp/ && wget https://bootstrap.pypa.io/get-pip.py
RUN sudo python2 /tmp/get-pip.py
RUN apt-get -y install vim
RUN sudo rm -r /usr/lib/python2.7/dist-packages/tornado/

ADD requirements.txt /tmp/requirements.txt
RUN pip2 install -r /tmp/requirements.txt

# Install Torch
# -------------

RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -yq \
  wget

RUN CUDA_REPO_PKG=cuda-repo-ubuntu1404_7.5-18_amd64.deb && \
    wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/$CUDA_REPO_PKG && \
    sudo dpkg -i $CUDA_REPO_PKG

RUN ML_REPO_PKG=nvidia-machine-learning-repo_4.0-2_amd64.deb && \
    wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1404/x86_64/$ML_REPO_PKG && \
    sudo dpkg -i $ML_REPO_PKG

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
RUN cd ~/itorch && /root/torch/install/bin/luarocks make

# Install loadcaffe
RUN CC="gcc-4.8" CXX="g++-4.8" /root/torch/install/bin/luarocks install loadcaffe

