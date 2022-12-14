
PYTHON=3.8
BASENAME=$(shell basename $(CURDIR))
CONDA_CH=pytorch defaults conda-forge

env:
	conda create -n $(BASENAME)  python=$(PYTHON)

setup:
	pip install -r requirements-pip.txt

mnist:
	wget --no-check-certificate http://yann.lecun.com/exdb/mnist/train-images-idx3-ubyte.gz
	wget --no-check-certificate http://yann.lecun.com/exdb/mnist/train-labels-idx1-ubyte.gz
	wget --no-check-certificate http://yann.lecun.com/exdb/mnist/t10k-images-idx3-ubyte.gz
	wget --no-check-certificate http://yann.lecun.com/exdb/mnist/t10k-labels-idx1-ubyte.gz

	gzip -f -d train-images-idx3-ubyte.gz
	gzip -f -d train-labels-idx1-ubyte.gz
	gzip -f -d t10k-images-idx3-ubyte.gz
	gzip -f -d t10k-labels-idx1-ubyte.gz

	mkdir -p dataset
	mv *ubyte dataset/
