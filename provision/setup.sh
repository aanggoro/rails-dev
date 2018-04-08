#!/bin/bash

echo "Provisioning virtual machine..."

echo "add depedencies"
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -y
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - -y
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list -y

echo "update and install package for rails"
sudo apt-get update -y
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs yarn -y

echo "install ruby and depedencies"
cd
git clone https://github.com/rbenv/rbenv.git ~/.rbenv 
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

rbenv install 2.5.0
rbenv global 2.5.0
ruby -v

echo "rehash and install rails"

gem install bundler
gem install rails

echo "install mysql"
apt-get install debconf-utils -y
debconf-set-selections <<< "mysql-server mysql-server/root_password password 1234"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password 1234"
apt-get install mysql-server mysql-client libmysqlclient-dev -y
