#!/usr/bin/env bash

source $HOME/.rvm/scripts/rvm

rvm use --default --install $1

shift

if [ $# -gt 0 ]
then
    name=$1
    version=$2
    gemset=${name}_${version}
    rvm gemset create ${gemset}
    rvm gemset use ${gemset}
    gem install $name -v $version
fi

rvm cleanup all

