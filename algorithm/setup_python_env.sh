#!/bin/bash

echo 'creating python virtual environment'
python -m venv social-hues-venv
source social-hues-venv/bin/activate
echo ''

echo 'install python dependencies from requirements.txt'
pip install -r requirements.txt
echo ''

# install sompy
echo 'installing sompy package'
wget https://github.com/sevamoo/SOMPY/archive/master.zip
unzip master.zip -d .
rm master.zip
echo ''