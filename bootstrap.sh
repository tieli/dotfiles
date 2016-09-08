#!/usr/bin/env bash

## Fetch all rc files
rc_files=(.railsrc .bashrc .gemrc .irbrc .ansible.cfg .bash_aliases .screenrc .gemrc .vimrc)

root_url="https://raw.githubusercontent.com/tieli/dotfiles/master"

for rc_file in ${rc_files[@]}
do
    echo "${root_url}/$rc_file"
    wget -N -P $HOME "${root_url}/$rc_file"
done


