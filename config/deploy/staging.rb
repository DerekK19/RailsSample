role :web, "localhost"							# Your HTTP server, Apache/etc
role :app, "localhost"							# This may be the same as your `Web` server
role :db,  "localhost", :primary => true		# This is where Rails migrations will run
role :db,  "localhost"

set(:deploy_to) { "/Users/Shared/Sites/Rails/sample" }
set :use_sudo, false

ssh_options[:forward_agent] = true