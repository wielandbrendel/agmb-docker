from wielandbrendel/jupyter-scipyserver:ubuntu-14.04

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
