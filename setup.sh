echo "Provisioning virtual machine..."

    echo "add depedencies"
    curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

    echo "update and install package for rails"
    sudo apt-get -y update
    sudo apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs yarn multipath-tools

    echo "install ruby and depedencies"
    cd
    wget http://ftp.ruby-lang.org/pub/ruby/2.5/ruby-2.5.0.tar.gz 
    tar -xzvf ruby-2.5.0.tar.gz
    cd ruby-2.5.0/
    ./configure
    make
    sudo make install
    ruby -v

    echo "rehash and install rails"
  
    gem install bundler
    gem install rails -v 5.1.4
 
    echo "install mysql"
    apt-get install -y debconf-utils
    debconf-set-selections <<< "mysql-server mysql-server/root_password password anhar09"
    debconf-set-selections <<< "mysql-server mysql-server/root_password_again password anhar09"
    apt-get install -y mysql-server mysql-client libmysqlclient-dev	
