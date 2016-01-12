from wielandbrendel/jupyter-scipyserver:cuda7.0-cudnn3

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

# Install Torch dependencies not installed in base image or above
RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -yq \
  libreadline-dev \
  git-core \
  libqt4-core \
  libqt4-gui \
  libqt4-dev \
  libjpeg-dev \
  libpng-dev \
  ncurses-dev \
  libzmq3-dev \
  libfftw3-dev \
  imagemagick \
  libgraphicsmagick1-dev \
  gnuplot \
  gnuplot-x11 \
  libsdl2-dev \
  sox \
  libsox-dev \
  libsox-fmt-all \
  libssl-dev \
  python-zmq

# Install Torch
RUN git clone https://github.com/torch/distro.git ~/torch --recursive
RUN git config --global url.https://github.com/.insteadOf git://github.com/
RUN cd ~/torch && ./install.sh
RUN git config --unset --global url.https://github.com/.insteadOf

# Install loadcaffe
RUN CC="gcc-4.8" CXX="g++-4.8" /root/torch/install/bin/luarocks install loadcaffe

