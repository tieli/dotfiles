#!/usr/bin/env bash

#gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
#curl -sSL https://get.rvm.io | bash -s $1

###########################################
# To fix 
# Failed to connect to raw.githubusercontent.com port 443: Connection refused
# Add the following line to /etc/hosts
# 199.232.28.133 raw.githubusercontent.com
###########################################

################################
# Sat Mar 20 09:39:21 UTC 2021
################################

gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

curl -sSL https://get.rvm.io | bash -s $1

