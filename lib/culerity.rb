require File.dirname(__FILE__) + '/culerity/remote_object_proxy'
require File.dirname(__FILE__) + '/culerity/remote_browser_proxy'

Symbol.class_eval do
  def to_proc
    Proc.new{|object| object.send(self)}
  end
end unless :symbol.respond_to?(:to_proc)

module Culerity

  module ServerCommands
    def exit_server
      self << '["_exit_"]'
      Process.kill(6, self.pid.to_i)
    end

    def close_browsers
      self.puts '["_close_browsers_"]'
    end
  end

  def self.run_server
    IO.popen("jruby #{__FILE__}", 'r+').extend(ServerCommands)

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
  
  def self.run_rails(options = {})
    if defined?(Rails) && !File.exists?("tmp/culerity_rails_server.pid")
      puts "WARNING: Speed up execution by running 'rake culerity:rails:start'"
      port        = options[:port] || 3001
      environment = options[:environment] || 'culerity_development'
      puts "Launched rails on :#{port}..."
      io = IO.popen("script/server -e #{environment} -p #{port}", 'r+')
      sleep 5
      io
    end
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
  Culerity::CelerityServer.new STDIN, STDOUT
end

