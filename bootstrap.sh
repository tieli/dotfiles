#!/usr/bin/env bash

#Install Vundle
mkdir -p .vim/bundle
cd ~/.vim/bundle && git clone https://github.com/VundleVim/Vundle.vim.git

#Install Pathogen
mkdir -p ~/.vim/autoload && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cd ~/.vim/bundle && git clone git://github.com/godlygeek/tabular.git

ln -s /vagrant/works ~/works

# Install Python related stuff
wget https://bootstrap.pypa.io/get-pip.py

sudo python ~/get-pip.py
sudo pip install virtualenv
sudo pip install ansible

