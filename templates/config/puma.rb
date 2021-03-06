workers Integer( {{ PUMA_WORKERS | default(2) }})
threads_count = Integer({{ PUMA_MAX_THREADS | default(2) }} )
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        {{ PUMA_PORT | default(9000) }}
environment "{{ RACK_ENV | default('production') }}"

on_worker_boot do
    # Worker specific setup for Rails 4.1+
  #   # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  #     ActiveRecord::Base.establish_connection
  #     end
end
