require File.dirname(__FILE__) + '/culerity/remote_object_proxy'
require File.dirname(__FILE__) + '/culerity/remote_browser_proxy'

module Culerity

  def self.run_server
    IO.popen("jruby #{__FILE__}", 'r+')
    # pid = fork { exec "jruby #{__FILE__}") }
    # Process.detach pid
    
    # store celerity pid in tmp/culerity_celerity.pid
    # store server pid in tmp/culerity_rails_server.pid
    
    # open named pipes to communicate with celerity_server + return them
  end
  
end

if __FILE__ == $0
  require File.dirname(__FILE__) + '/culerity/celerity_server'
  Culerity::CelerityServer.new STDIN, STDOUT
end

