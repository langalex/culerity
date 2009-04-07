require File.dirname(__FILE__) + '/culerity/remote_object_proxy'
require File.dirname(__FILE__) + '/culerity/remote_browser_proxy'

module Culerity

  def self.run_server
    IO.popen("jruby #{__FILE__}", 'r+')
  end
  
end

if __FILE__ == $0
  require File.dirname(__FILE__) + '/culerity/celerity_server'
  Culerity::CelerityServer.new STDIN, STDOUT
end

