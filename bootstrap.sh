#!/usr/bin/env bash

#Install Vundle
mkdir -p .vim/bundle
cd ~/.vim/bundle && git clone https://github.com/VundleVim/Vundle.vim.git

#Install Pathogen
mkdir -p ~/.vim/autoload && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cd ~/.vim/bundle && git clone git://github.com/godlygeek/tabular.git

# Install PhantomJS
ARCH=$(uname -m)

if ! [ $ARCH = "x86_64" ]; then
	$ARCH="i686"
fi

cd ~ && export PHANTOM_JS="phantomjs-1.9.8-linux-x86_64"

wget https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2
tar xvjf $PHANTOM_JS.tar.bz2

sudo mv $PHANTOM_JS /usr/local/share
sudo ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin

echo 'export DISPLAY="10:0.0"' >> ~/.bashrc

ln -s /vagrant/works ~/works

# Install Python related stuff
wget https://bootstrap.pypa.io/get-pip.py

sudo python ~/get-pip.py
sudo pip install virtualenv
sudo pip install ansible

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable

# Install Ruby related stuff
source /home/vagrant/.rvm/scripts/rvm
rvm install 2.1.9
rvm gemset create rails_4_1_15
rvm gemset use rails_4_1_15
gem install rails -v 4.1.15

rvm gemset create rails_4_2_6
rvm install 2.2.5
rvm gemset use rails_4_2_6
gem install rails -v 4.2.6
rvm use ruby-2.2.5@rails_4_2_6 --default

