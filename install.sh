#!/bin/bash

brew install ipopt
IPOPT_DIR=$(brew info ipopt | grep -E "^/" | cut -d\  -f1)

pip install numpy scipy lxml nose cython
brew install --python wxmac --devel

svn co https://svn.jmodelica.org/tags/1.8.1/ jmodelica
mkdir jmodelica/build
pushd jmodelica/build

wget http://sourceforge.net/projects/jpype/files/JPype/0.5.4/JPype-0.5.4.2.zip/download
unzip download
pushd JPype-0.5.4.2
cp $(dirname $0)/jpype.setup.py setup.py
python setup.py install
popd

../configure --with-ipopt=$IPOPT_DIR
make
make install
make test

/usr/local/jmodelica/bin/jm_python.sh $(dirname $0)/test.py

popd
