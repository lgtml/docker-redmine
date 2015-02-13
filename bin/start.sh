cd /templates/config
for i in `ls -1`
do
  generate_config.py --template $i --dest /opt/redmine/config
done
cd /opt/redmine
# Run again now that database.yml is setup
bundle exec rake db:migrate RAILS_ENV="production"
bundle exec rake redmine:load_default_data RAILS_ENV="production"
yes en|bundle exec rake redmine:load_default_data RAILS_ENV="production"
bundle exec puma -e production -p 9000
