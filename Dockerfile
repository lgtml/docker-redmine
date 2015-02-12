FROM ubuntu:14.04

RUN apt-get update && \
  apt-get install -y zlib1g-dev libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties && \
  apt-get install -y build-essential curl python-pip && \
  pip install jinja
  curl -o ruby-2.1.5.tar.gz -L http://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.5.tar.gz && \
  tar -xzvf ruby-2.1.5.tar.gz && \
  cd ruby-2.1.5/ && \
  ./configure && \
  make && \
  make install && \
  cd ../ && \
  curl -o redmine-2.6.1.tar.gz -L http://www.redmine.org/releases/redmine-2.6.1.tar.gz && \
  tar xvzf redmine-2.6.1.tar.gz && \
  adduser --disabled-login --gecos 'Redmine' redmine && \
  mv redmine-2.6.1 redmine && \
  chown -R redmine redmine && \
  rm -rf redmine-2.6.1.tar.gz && \
  apt-get remove -y zlib1g-dev libssl-dev libreadline-dev libyaml-dev libsqlite3-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties && \
  apt-get remove -y build-essential curl && \
  apt-get clean && apt-get purge && apt-get autoremove -y && \
  rm -rf ruby-2.1.5.tar.gz && \
  rm -rf ruby-2.1.5 && \
  rm -rf rm -rf /usr/local/share/ri/ && \

ADD generate_config.py /usr/bin/
