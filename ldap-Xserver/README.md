# LDAP & Xserver configuration

Modification of Docker Image by [Alexander Ecker](https://github.com/aecker/docker). Enables the following features:

1. Using LDAP user within a Docker container (more precisely: emulates it by using a local user with the same uid).
2. Runs an X server.
3. SSH daemon, i.e. allows `ssh -X` to run GUI within the Docker container.

The following environmental variables can be passed as flags at runtime:

* `USER` -- your user account
* `USER_ID` -- your user id. To find out your id: `id -u USER`
* `USER_ENCRYPTED_PASSWORD` -- your user password (encrypted). To generate it: `perl -e 'print crypt('"PASSWORD"', "aa"),"\n"'`

To start the container, make sure to mount `/gpfs01/bethge` and expose the ports,

`docker run -d -P -v /gpfs01/bethge:/gpfs01/bethge -e "USER=user" -e "USER_ID=used_id" -e "USER_ENCRYPTED_PASSWORD=password" wielandbrendel/ldap-xserver:ubuntu-14.04`

### CUDA-based images

The ldap-xserver image comes with different CUDA versions, each of which is exposed as a tag on Docker hub. Currently we support

* `ubuntu-14.04`
* `cuda6.5` -- Ubuntu 14.04 with compiler toolchain, debugging tools and the development files for the standard CUDA 6.5 libraries.
* `cuda7.0-cudnn3` -- Same as cuda6.5 buth with CUDA 7.0 and CuDNN v3

To run CUDA-based images the NVIDIA wrapper (see below) is needed,

`GPU=0,1 ./nvidia-docker run -d -P -v /gpfs01/bethge:/gpfs01/bethge -e "USER=user" -e "USER_ID=used_id" -e "USER_ENCRYPTED_PASSWORD=password" wielandbrendel/ldap-xserver:ubuntu-14.04`


### Note

Do not override the `CMD` in bethgelab-users. If you need to execute additional programs when starting the container, add them to `/usr/local/bin/startup` as follows:

`RUN echo "./mycmd" >> /usr/local/bin/startup`

### NVIDIA Docker wrapper

All CUDA-images are based on the offical docker images provided by [Nvidia](https://github.com/NVIDIA/nvidia-docker). To run a CUDA-based image (but not the Ubuntu-image), the wrapper script ```nvidia-docker``` from the [nvidia-docker repository](https://github.com/NVIDIA/nvidia-docker) is need to run the container. The ```nvidia-docker``` script is a drop-in replacement for ```docker``` CLI. In addition, it takes care of setting up the NVIDIA host driver environment inside Docker containers for proper execution.

GPUs are exported through a list of comma-separated IDs using the environment variable ```GPU```.
The numbering is the same as reported by ```nvidia-smi``` or when running CUDA code with ```CUDA_DEVICE_ORDER=PCI_BUS_ID```, it is however **different** from the default CUDA ordering.

```sh
GPU=0,1 ./nvidia-docker <docker-options> <docker-command> <docker-args>
```
