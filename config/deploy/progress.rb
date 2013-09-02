require "colored"

#logger.level = Logger::IMPORTANT               # make capistrano quiet by default!

STDOUT.sync
before "deploy:setup" do
    print "Updating Rvm........"
    start_spinner()
end

after "deploy:setup" do
    stop_spinner()
    puts "Done.".green
end

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
