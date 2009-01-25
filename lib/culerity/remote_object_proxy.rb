module Culerity

  class RemoteObjectProxy
    def initialize(remote_object_id, io)
      @remote_object_id = remote_object_id
      @io = io
    end
    
    def method_missing(name, *args)
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
        raise "#{res[1]}: #{res[2]}"
      end
    end
    
    def remote_object_id
      @remote_object_id
    end
  end
end