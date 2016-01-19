# only the following tag is built if not stated otherwise
basetag=cuda7.0-cudnn3
alltags=ubuntu-14.04 cuda6.5 cuda7.0-cudnn3
ldapbaseimages=ubuntu:14.04 nvidia/cuda:6.5-devel nvidia/cuda:7.0-cudnn3-devel

build-all:
	docker build -t wielandbrendel/ldap-xserver:$(basetag) ldap-Xserver/$(basetag)/
	docker build -t wielandbrendel/jupyter-notebook:$(basetag) jupyter-notebook/$(basetag)/
	docker build -t wielandbrendel/jupyter-scipyserver-python2:$(basetag) jupyter-scipyserver-python2/$(basetag)/
	docker build -t wielandbrendel/jupyter-scipyserver:$(basetag) jupyter-scipyserver/$(basetag)/
	docker build -t wielandbrendel/jupyter-deeplearning:$(basetag) jupyter-deeplearning/$(basetag)/

build-ldap:
	docker build -t wielandbrendel/ldap-xserver:$(basetag) ldap-Xserver/$(basetag)/

trouble-ldap:
	GPU=0,1 ./agmb-docker -it wielandbrendel/ldap-xserver:$(basetag)

run-ldap:
	GPU=0,1 ./agmb-docker -d wielandbrendel/ldap-xserver:$(basetag)

docker-ldap:
	make vim-image image=ldap-Xserver file=Dockerfile
	python utils/set_ldap_baseimages.py '$(alltags)' '$(ldapbaseimages)'

vim-ldap:
	make vim-image image=ldap-Xserver

build-notebook:
	docker build -t wielandbrendel/jupyter-notebook:$(basetag) jupyter-notebook/$(basetag)/

run-notebook:
	GPU=0,1 ./agmb-docker -d wielandbrendel/jupyter-notebook:$(basetag)

run-scipyserver:
	# docker pull wielandbrendel/jupyter-scipyserver:$(basetag)
	GPU=0,1 ./agmb-docker run -d wielandbrendel/jupyter-scipyserver:$(basetag)

run-deeplearning:
	docker pull wielandbrendel/jupyter-deeplearning:$(basetag)
	GPU=0,1 ./agmb-docker -d wielandbrendel/jupyter-deeplearning:$(basetag)

# opens the Dockerfile in vim and syncs across tags after closing
docker-deeplearning: 
	make docker-image image=jupyter-deeplearning baseimage=jupyter-scipyserver

# opens any file (use file=... as argument) in vim and syncs across tags after closing
vim-deeplearning: 
	make vim-image image=jupyter-deeplearning

docker-scipyserver: 
	make docker-image image=jupyter-scipyserver baseimage=jupyter-scipyserver-python2

vim-scipyserver: 
	make vim-image image=jupyter-scipyserver

docker-scipyserver2: 
	make docker-image image=jupyter-scipyserver-python2 baseimage=jupyter-notebook

vim-scipyserver2: 
	make vim-image image=jupyter-scipyserver-python2

docker-notebook:
	make docker-image image=jupyter-notebook baseimage=ldap-xserver

vim-notebook: 
	make vim-image image=jupyter-notebook

docker-ldap:
	make vim-image image=ldap-Xserver file=Dockerfile
	python utils/set_ldap_baseimages.py '$(alltags)' '$(ldapbaseimages)'

vim-ldap:
	make vim-image image=ldap-Xserver

# opens file and syncs across tags
vim-image:
	vim $(image)/$(basetag)/$(file)
	make sync-file image=$(image) file=$(file)

# opens Dockerfile, syncs across tags and replaces first line
docker-image:
	vim $(image)/$(basetag)/Dockerfile
	make sync-file image=$(image) file=Dockerfile
	make setbase-dockerfile image=$(image) baseimage=$(baseimage)

# sync a file from basetag directory to all other tags
sync-file:
	for tag in $(alltags) ; do \
           cp $(image)/$(basetag)/$(file) $(image)/$$tag/$(file)  2>/dev/null || : ; \
        done

# set the correct base images for all tags
setbase-dockerfile:
	for tag in $(alltags) ; do \
           sed -i '1 s%^.*%FROM wielandbrendel/$(baseimage):'$$tag'%' $(image)/$$tag/Dockerfile ; \
        done

build-deeplearning-single:
	docker build -t wielandbrendel/jupyter-deeplearning:$(basetag) jupyter-deeplearning/$(basetag)/
