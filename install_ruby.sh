#!/usr/bin/env bash
source $HOME/.rvm/scripts/rvm

display_usage() {
    echo -e "\n==========================================\n"
    echo -e "Usage: install_ruby ruby 2.7.1 rails 5.2\n"
    echo -e "Usage: install_ruby ruby 3.0 rails 6.0\n"
    echo -e "\n==========================================\n"
}

if [ $# -le 1 ]
then
    display_usage
    exit 1
fi

if [[ ( $# == "--help") || $# == "-h" ]]
then
    display_usage
    exit 0
fi

# shift out keyword ruby
shift
rvm use --default --install $1

shift
name=$1

# shift out keyword rails
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

