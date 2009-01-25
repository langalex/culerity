require 'rubygems'
require 'celerity'


module Culerity
  class CelerityServer
    
    def initialize(_in, _out)
      @browser = Celerity::Browser.new
      @proxies = {}
      
      while(true)
        call = eval _in.gets.to_s.strip
        return  if call == ["_exit_"]
        unless call.nil?
          begin
            result = target(call.first).send call[1], *call[2..-1]
            _out << "[:return, #{proxify result}]\n"
          rescue => e
            _out << "[:exception, \"#{e.class}\", #{e.message.inspect}]\n"
          end
        end
      end
      
    end
    
    private
    
    def target(object_id)
      if object_id == 'browser'
        @browser
      else
        @proxies[object_id]
      end
    end
    
    def proxify(result)
      if [String, TrueClass, FalseClass, Fixnum, Float, NilClass].include?(result.class)
        result.inspect
      else
        @proxies[result.object_id] = result
        "Culerity::RemoteObjectProxy.new(#{result.object_id}, @io)"
      end
    end
  end
end