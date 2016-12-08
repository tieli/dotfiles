#!/usr/bin/env bash

## Fetch all rc files
rc_files=(.gitconfig .railsrc .bashrc .gemrc .irbrc .ansible.cfg .bash_aliases .screenrc .gemrc .vimrc)

root_url="https://raw.githubusercontent.com/tieli/dotfiles/master"

for rc_file in ${rc_files[@]}
do
    echo "${root_url}/$rc_file"
    wget -N -P $HOME "${root_url}/$rc_file"
done

vim_rc_url="https://raw.githubusercontent.com/tieli/dotfiles/master/.vimrc"
wget -N -P $HOME $vim_rc_url

vim +PluginInstall +qall

ln -s /vagrant/works ~/works

sudo apt-get update
sudo apt-get install -y git vim build-essential libssl-dev libffi-dev python-dev

mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#mkdir -p ~/.vim/autoload && \
#curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

wget https://bootstrap.pypa.io/get-pip.py
sudo python ~/get-pip.py
sudo pip install virtualenv
sudo pip install ansible
sudo pip install pexpect

# setting up keychain
ssh-keygen -f $HOME/.ssh/id_rsa -t rsa -N ''
ssh-keygen -f $HOME/.ssh/id_dsa -t dsa -N ''


