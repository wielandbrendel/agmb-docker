FROM nvidia/cuda:6.5-devel 
MAINTAINER Wieland Brendel "wieland.brendel@bethgelab.org" 

# Install X11, SSH and sudo
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y openssh-server pwgen xpra rox-filer xserver-xephyr xdm fluxbox xvfb sudo xterm

# Configuring xdm to allow connections from any IP address and ssh to allow X11 Forwarding. 
RUN sed -i 's/DisplayManager.requestPort/!DisplayManager.requestPort/g' /etc/X11/xdm/xdm-config
RUN sed -i '/#any host/c\*' /etc/X11/xdm/Xaccess
RUN ln -s /usr/bin/Xorg /usr/bin/X
RUN echo X11Forwarding yes >> /etc/ssh/ssh_config

# Fix PAM login issue with sshd
RUN sed -i 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/g' /etc/pam.d/sshd

# Set locale (fix the locale warnings)
RUN localedef -v -c -i en_US -f UTF-8 en_US.UTF-8 || :

# Expose SSH port
EXPOSE 22

# Create the directory needed to run the sshd daemon
RUN mkdir /var/run/sshd 

# restarts the xdm service
RUN /etc/init.d/xdm restart

# Create groups
RUN addgroup cin
RUN groupmod -g 1011 cin
RUN addgroup bethgelab
RUN groupmod -g 1019 bethgelab

# Copy the config files into the docker directory
COPY bin/* /usr/local/bin/

# Start the ssh service
CMD run
