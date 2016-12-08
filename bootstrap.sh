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


# Install PhantomJS

PHANTOM_JS="phantomjs-2.1.1-linux-x86_64"
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user" 2>&1
  exit 1
else
	apt-get update
	apt-get install -y build-essential chrpath libssl-dev libxft-dev 
	apt-get install -y libfreetype6 libfreetype6-dev
	apt-get install -y libfontconfig1 libfontconfig1-dev
	cd ~
	wget https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2
	mv $PHANTOM_JS.tar.bz2 /usr/local/share/
	cd /usr/local/share/
	tar xvjf $PHANTOM_JS.tar.bz2
	ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/share/phantomjs
	ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin/phantomjs
	ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/bin/phantomjs
	rm -fr $PHANTOM_JS.tar.bz2
fi
