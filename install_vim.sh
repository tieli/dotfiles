#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install -y git vim build-essential libssl-dev libffi-dev python-dev

mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#mkdir -p ~/.vim/autoload && \
#curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

vim_rc_url="https://raw.githubusercontent.com/tieli/dotfiles/master/.vimrc"
wget -N -P $HOME $vim_rc_url

vim +PluginInstall +qall

ln -s /vagrant/works ~/works

wget https://bootstrap.pypa.io/get-pip.py
sudo python ~/get-pip.py
sudo pip install virtualenv
sudo pip install ansible
sudo pip install pexpect


