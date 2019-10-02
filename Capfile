require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"
require 'capistrano/rbenv'
require "capistrano/rails"
require "capistrano/bundler"
require "capistrano/rails/migrations"
require "capistrano/puma"
require "capistrano/scm/git"
require 'capistrano/sidekiq'
install_plugin Capistrano::SCM::Git
install_plugin Capistrano::Puma

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
