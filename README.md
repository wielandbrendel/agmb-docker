# Docker Toolchain of AG Bethge

This repository includes utilities to build and run Docker images in the group of [AG Bethge](http://bethgelab.org/). The toolchain is composed of four different images (more images below):

* The __ldap-xserver image__ adds user-authentication and Xserver capabilities to a base Ubuntu-image. This fixed a problem with the standard root user, for which all files written from within the Docker container back to the host system are owned by root and thus conflict with user permissions.

* The __jupyter-notebook image__ is a fork of the official [jupyter/notebook image](https://hub.docker.com/r/jupyter/notebook/) but is based on ldap-xserver.

* The __jupyter-scipyserver image__ is based on jupyter-notebook but adds many python packages needed for scientific computing such as Numpy and Scipy (both compiled against OpenBlas), Theano, Lasagne, Pandas, Seaborn and more. Note that this image split into two parts - jupyter-scipyserver-python2 and jupyter-scipyserver - to avoid time outs on Docker Hub during the build process.

* The __jupyter-deeplearning image__ is based on jupyter-scipyserver (including Lasagne) but adds some libraries such as Caffe, Torch, Tensorflow, Keras, Scikit-image, Joblib and others.

All images come with different (or no) CUDA-libraries installed. Currently we support plain Ubuntu 14.04, Ubuntu 14.04 + Cuda 6.5 or Ubuntu 14.04 + Cuda 7.0 + CuDNN v3. For detailed instructions on how to build and run each of the images, please refer to the respective subfolders. All images are readily available from [Docker Hub](https://hub.docker.com/u/wielandbrendel/).

### AGMB Docker wrapper

To make the employment of the containers as painless as possible we have wrapped all important flags in the script ```agmb-docker``` (see root directory of repo), which is a modification of the ```nvidia-docker``` wrapper from the [nvidia-docker repository](https://github.com/NVIDIA/nvidia-docker). To run a container, first pull the image from Docker Hub (important - see below) before running the command

    GPU=0,1 /.agmb-docker -d wielandbrendel/jupyter-deeplearning:cuda7.0-cudnn3
    
or equivalently for any other image or tag. This command has to be run in the folder in which the agmb-docker script was placed. The script takes care of setting up the NVIDIA host driver environment inside the Docker container, adds the current user, mounts his home-directory in which it finally starts the jupyter notebook. Some properties are specific to users within the AG Bethge lab, but as an external user one can override all settings. As the most stripped-down version, use

    GPU=0,1 /.agmb-docker -e GROUPS=sudo -e USER_HOME=$HOME -d wielandbrendel/jupyter-deeplearning:cuda7.0-cudnn3

Note that all the usual docker flags can be given. In addition, some environmental variables have a special meaning

* ```USER```  --  The username that is added to the container
* ```USER_ID```  --  The user ID for the new user
* ```USER_GROUPS```  --  The groups to which the user is added (default: sudo,bethgelab:1011,cin:1019)
* ```USER_ENCRYPTED_PASSWORD```  --  your user password (encrypted). To generate it: ```perl -e 'print crypt('"PASSWORD"', "aa"),"\n"' ```

GPUs are exported through a list of comma-separated IDs using the environment variable ```GPU```.
The numbering is the same as reported by ```nvidia-smi``` or when running CUDA code with ```CUDA_DEVICE_ORDER=PCI_BUS_ID```, it is however **different** from the default CUDA ordering.



# Issues and Contributing
* Please let us know by [filing a new issue](https://github.com/wielandbrendel/agmb-docker/issues/new)
* You can contribute by opening a [pull request](https://help.github.com/articles/using-pull-requests/)  
