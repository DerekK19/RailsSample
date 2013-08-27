require "rvm/capistrano"
require "capistrano/ext/multistage"
load "config/deploy/progress"

set :stages, ["staging", "production"]
set :default_stage, "staging"

set :rvm_ruby_string, :local                    # use the same ruby as used locally for deployment

before 'deploy:setup', 'rvm:install_rvm'        # update RVM
before 'deploy:setup', 'rvm:install_ruby'       # install Ruby and create gemset (both if missing)

set :keep_releases, 1

set :application, "sample"
set :repository,  "$HOME/Solutions/Rails/sample"

set :scm, :none

ssh_options[:forward_agent] = true

set :normalize_asset_timestamps, false			# disable asset timestamps update, since rails doesn't use these

<<<<<<< HEAD
after "deploy:restart", "deploy:cleanup"
=======
after "deploy:restart", "deploy:cleanup"        # clean up old releases on each deploy

role :web, "localhost"                          # Your HTTP server, Apache/etc
role :app, "localhost"                          # This may be the same as your `Web` server
role :db,  "localhost", :primary => true		# This is where Rails migrations will run
role :db,  "localhost"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
>>>>>>> 5fa019bdf8f40f5db48049eb9c518f7e30cf9561
