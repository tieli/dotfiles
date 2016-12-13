#!/usr/bin/env bash

source $HOME/.rvm/scripts/rvm

rvm use --default --install $1

shift

name=$1

shift

while [ $# -gt 0 ]
do
    version=$1
    gemset=${name}_${version}
    rvm gemset create ${gemset}
    rvm gemset use ${gemset}
    gem install $name -v $version
    shift
done

rvm cleanup all

