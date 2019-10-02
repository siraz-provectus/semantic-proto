# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :repo_url,         "git@github.com:siraz-provectus/semantic-proto.git"
set :format, :pretty
set :log_level, :debug
set :pty, true
set :use_sudo,        false
# set :assets_roles, [:assets]

set :linked_files, %w[.env]
set :linked_dirs,  %w[log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads node_modules client]

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true

