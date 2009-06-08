module Culerity
  
  class CulerityException < StandardError
    def initialize(message, backtrace)
      super message
      #self.backtrace = backtrace
    end
  end

  class RemoteObjectProxy
    def initialize(remote_object_id, io)
      @remote_object_id = remote_object_id
      @io = io
    end
    
    #
    # Commonly used to get the HTML id attribute
    # Use `object_id` to get the local objects' id.
    #
    def id
      send_remote(:id)
    end
    
    def method_missing(name, *args)
      send_remote(name, *args)
    end
    
    #
    # Calls the passed method on the remote object with any arguments specified.
    # Behaves the same as <code>Object#send</code>.
    #
    def send_remote(name, *args)
      @io << "[#{remote_object_id}, \"#{name}\", #{args.map{|a| a.inspect}.join(', ')}]\n"
      process_result @io.gets.to_s.strip
    end
    
    def exit
      @io << '["_exit_"]'
    end
    
    private
    
    def process_result(result)
      res = eval result
      if res.first == :return
        res[1]
      elsif res.first == :exception
        raise CulerityException.new("#{res[1]}: #{res[2]}", res[3])
      end
    end
    
    def remote_object_id
      @remote_object_id
    end
  end
end