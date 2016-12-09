#!/usr/bin/env bash

rc_files=(.ansible.cfg .bash_aliases .bashrc .gemrc .gitconfig .irbrc .railsrc .screenrc .vimrc)

for rc_file in ${rc_files[@]}
do
    diff $rc_file $HOME/$rc_file >> /dev/null
    if [ $? -ne 0 ]; then
        echo $rc_file
    fi
done

