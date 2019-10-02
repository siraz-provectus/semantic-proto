server "157.230.127.219", port: 22, roles: %i[web app db], primary: true
set :application, 'semantic-proto'
set :user,        "root"

set :stage, :production

set :ssh_options, {
  user: 'root',
}

# set :sidekiq_config, "config/sidekiq.yml"
# set :sidekiq_pid, "/home/#{fetch(:user)}/apps/#{fetch(:application)}/shared/tmp/pids/sidekiq.pid"
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_threads, [4,16]
set :puma_workers,    1
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "/home/#{fetch(:user)}/apps/#{fetch(:application)}/shared/tmp/pids/puma.state"
set :puma_pid,        "/home/#{fetch(:user)}/apps/#{fetch(:application)}/shared/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"