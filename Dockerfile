FROM ubuntu:14.04

ADD bin/generate_config.py /usr/bin/
RUN chmod +x /usr/bin/generate_config.py && \
  apt-get update && \
  apt-get install -y libyaml-0-2 zlib1g-dev libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties && \
  apt-get install -y build-essential curl python-pip python-dev && \
  pip install jinja && \
  curl -o ruby-2.1.5.tar.gz -L http://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.5.tar.gz && \
  tar -xzvf ruby-2.1.5.tar.gz && \
  cd ruby-2.1.5/ && \
  ./configure && \
  make && \
  make install && \
  gem install bundler && \
  apt-get remove -y zlib1g-dev libssl-dev libreadline-dev libyaml-dev libsqlite3-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties && \
  apt-get remove -y build-essential python-dev && \
  apt-get clean && apt-get purge && apt-get autoremove -y && \
  cd / && \
  rm -rf ruby-2.1.5.tar.gz && \
  rm -rf ruby-2.1.5 && \
  rm -rf rm -rf /usr/local/share/ri/

RUN mkdir -p /templates
ADD templates/ /templates

# Initialize redmine bundle
RUN apt-get update && \
  apt-get install -y libssl-dev libsqlite3-dev libpq-dev libmysqlclient-dev && \
  pip install jinja2 && \
  cd /opt && \
  curl -o redmine-2.6.1.tar.gz -L http://www.redmine.org/releases/redmine-2.6.1.tar.gz && \
  tar xvzf redmine-2.6.1.tar.gz && \
  adduser --disabled-login --gecos 'Redmine' redmine && \
  mv redmine-2.6.1 redmine && \
  chown -R redmine redmine && \
  rm -rf redmine-2.6.1.tar.gz && \
  cd /opt/redmine && \
  echo 'gem "puma"' >> Gemfile.local && \
  gem install puma --no-doc -v '2.11.1' && \
  gem install sqlite3 && \
  gem install pg && \
  gem install mysql && \
  bundle install --without test development rmagick && \
  apt-get remove -y libssl-dev libsqlite3-dev libpq-dev libmysqlclient-dev && \
  apt-get clean && apt-get purge && apt-get autoremove -y

ADD bin/start.sh /usr/bin/start.sh
RUN chmod +x /usr/bin/start.sh

#ENTRYPOINT [ "/usr/bin/start.sh" ]
