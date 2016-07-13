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

# Fetch all rc files
rc_files=(.railsrc .bashrc .gemrc .irbrc .ansible.cfg .bash_aliases .screenrc .gemrc)

root_url="https://raw.githubusercontent.com/tieli/dotfiles/master"

for rc_file in ${rc_files[@]}
do
    echo "${root_url}/$rc_file"
    wget -N "${root_url}/$rc_file"
done


