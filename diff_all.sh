#!/usr/bin/env bash

#todo
# 1. get the list of dotfiles automatically

rc_files=(.ansible.cfg .bash_aliases .bashrc .gemrc .gitconfig .irbrc .railsrc .screenrc .vimrc)

for rc_file in ${rc_files[@]}
do
    if [ -e $HOME/$rc_file ]; 
    then
        diff $rc_file $HOME/$rc_file >> /dev/null
        if [ $? -ne 0 ]; then
            echo "$rc_file has been changes."
        fi
    else
        echo "$rc_file does not exists."
    fi

done

