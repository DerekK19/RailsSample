require "rvm/capistrano"
require "capistrano/ext/multistage"
require "colored"

logger.level = Logger::IMPORTANT               # make capistrano quiet by default!

STDOUT.sync
before "deploy:update_code" do
    print "Updating Code........"
    start_spinner()
end

after "deploy:update_code" do
    stop_spinner()
    puts "Done.".green
end

before "deploy:cleanup" do
    print "Cleaning Up.........."
    start_spinner()
end

after "deploy:cleanup" do
    stop_spinner()
    puts "Done.".green
end

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

@spinner_running = false
@chars = ['|', '/', '-', '\\']
@spinner = Thread.new do
  loop do
    unless @spinner_running
      Thread.stop
    end
    print @chars[0]
    sleep(0.1)
    print "\b"
    @chars.push @chars.shift
  end
end

def start_spinner
  @spinner_running = true
  @spinner.wakeup
end

# stops the spinner and backspaces over last displayed character
def stop_spinner
  @spinner_running = false
  print "\b"
end

set :stages, ["staging", "production"]
set :default_stage, "staging"

set :rvm_ruby_string, :local                    # use the same ruby as used locally for deployment

before 'deploy:setup', 'rvm:install_rvm'        # update RVM
before 'deploy:setup', 'rvm:install_ruby'       # install Ruby and create gemset (both if missing)

set :keep_releases, 1

set :application, "sample"
set :repository,  "/Users/derekk/Solutions/Rails/sample"

set :scm, :none

set :normalize_asset_timestamps, false			# disable asset timestamps update, since rails doesn't use these

after "deploy:restart", "deploy:cleanup"
