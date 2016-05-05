#!/bin/bash

\\curl -sSL https://get.rvm.io | bash
rvm install 2.1.1
rvm gemset create rails_4_1_1
rvm gemset use rails_4_1_1
gem install rails -v 4.1.13
rvm use ruby-2.1.7@rails_4_1_1 --default
sudo apt-get update
sudo apt-get install -y xfce4

