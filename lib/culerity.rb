require File.dirname(__FILE__) + '/culerity/remote_object_proxy'
require File.dirname(__FILE__) + '/culerity/remote_browser_proxy'

module Culerity

  def self.run_server
    IO.popen("jruby #{__FILE__}", 'r+')

    # open the two pipes that were created below
    # while(!File.exists?("tmp/culerity_in.pipe")) 
    #   sleep(1)
    # end
    # pipe_in = open("tmp/culerity_in.pipe", "w+")
    # pipe_out = open("tmp/culerity_out.pipe", "r+")
    
    
    
    # store celerity pid in tmp/culerity_celerity.pid
    # store server pid in tmp/culerity_rails_server.pid
    
    # open named pipes to communicate with celerity_server + return them
  end
  
end

if __FILE__ == $0
  # `rm tmp/culerity_in.pipe`
  # `mkfifo tmp/culerity_in.pipe`
  # `rm tmp/culerity_out.pipe`
  # `mkfifo tmp/culerity_out.pipe`
  # 
  # pipe_in = open("tmp/culerity_in.pipe", "r+")
  # p pipe_in
  # p STDIN
  # pipe_out = open("tmp/culerity_out.pipe", "w+")
  # 
  require File.dirname(__FILE__) + '/culerity/celerity_server'
  Culerity::CelerityServer.new pipe_in, pipe_out
end

