Relies on `wielandbrendel/jupyter-notebook`, installs the [SciPy stack](http://www.scipy.org/stackspec.html) + more:

* cython
* h5py
* matplotlib
* numpy
* pandas
* patsy
* scikit-learn
* scipy
* seaborn
* sympy
* yt
* theano

To install, just call

`docker run -d -p 8888:8888 wielandbrendel/jupyter-scipyserver`

and access the running jupyter server via your browser on localhost:8888.
