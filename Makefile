update-notebook: update-notebook-ubuntu update-notebook-cuda6 update-notebook-cuda7

update-notebook-ubuntu:
	git subtree pull --prefix jupyter-notebook/ubuntu-14.04 jupyter_notebook_remote master --squash

update-notebook-cuda6:
	git subtree pull --prefix jupyter-notebook/cuda6.5 jupyter_notebook_remote master --squash

update-notebook-cuda7:
	git subtree pull --prefix jupyter-notebook/cuda7.0-cudnn3 jupyter_notebook_remote master --squash

# To add new tags based on jupyter notebook use
# git subtree add --prefix notebook jupyter_notebook_remote master --squash
# (details in our wiki)
