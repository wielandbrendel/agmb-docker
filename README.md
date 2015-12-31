# Docker Toolchain of AG Bethge

This repository includes utilities to build and run Docker images in the group of [AG Bethge](http://bethgelab.org/). The toolchain is composed of four different images:

* The __ldap-xserver image__ adds user-authentication and Xserver capabilities to a base Ubuntu-image. This fixed a problem with the standard root user, for which all files written from within the Docker container back to the host system are owned by root and thus conflict with user permissions.

* The __jupyter-notebook image__ is a fork of the official [jupyter/notebook image](https://hub.docker.com/r/jupyter/notebook/) but is based on ldap-xserver.

* The __jupyter-scipyserver image__ is based on jupyter-notebook but adds many python packages needed for scientific computing such as Numpy and Scipy (both compiled against OpenBlas), Theano, Pandas, Seaborn and more.

* The __jupyter-deeplearning image__ is based on jupyter-scipyserver but adds some libraries such as Lasagne, Scikit-image, Joblib and others. 

All images come with different (or no) CUDA-libraries installed. Currently we support plain Ubuntu 14.04, Ubuntu 14.04 + Cuda 6.5 or Ubuntu 14.04 + Cuda 7.0 + CuDNN v3. For detailed instructions on how to build and run each of the images, please refer to the respective subfolders. All images are readily available from [Docker Hub](https://hub.docker.com/u/wielandbrendel/).

### NVIDIA Docker wrapper

All CUDA-images are based on the offical docker images provided by [Nvidia](https://github.com/NVIDIA/nvidia-docker). To run a CUDA-based image (but not the Ubuntu-image), the wrapper script ```nvidia-docker``` from the [nvidia-docker repository](https://github.com/NVIDIA/nvidia-docker) is need to run the container. The ```nvidia-docker``` script is a drop-in replacement for ```docker``` CLI. In addition, it takes care of setting up the NVIDIA host driver environment inside Docker containers for proper execution.

GPUs are exported through a list of comma-separated IDs using the environment variable ```GPU```.
The numbering is the same as reported by ```nvidia-smi``` or when running CUDA code with ```CUDA_DEVICE_ORDER=PCI_BUS_ID```, it is however **different** from the default CUDA ordering.

```sh
GPU=0,1 ./nvidia-docker <docker-options> <docker-command> <docker-args>
```

# Issues and Contributing
* Please let us know by [filing a new issue](https://github.com/wielandbrendel/agmb-docker/issues/new)
* You can contribute by opening a [pull request](https://help.github.com/articles/using-pull-requests/)  
