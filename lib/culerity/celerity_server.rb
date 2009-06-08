require 'rubygems'
require 'celerity'


module Culerity
  class CelerityServer
    
    def initialize(_in, _out)
      @proxies = {}
      @browser_options = {}
      
      while(true)
        call = eval _in.gets.to_s.strip
        return  if call == ["_exit_"]
        unless call.nil?
          begin
            result = target(call.first).send call[1], *call[2..-1]
            _out << "[:return, #{proxify result}]\n"
          rescue => e
            _out << "[:exception, \"#{e.class.name}\", #{e.message.inspect}, #{e.backtrace.inspect}]\n"
          end
        end
      end
      
    end
    
    private
    
    def configure_browser(options)
      @browser_options = options
    end
    
    def browser
      @browser ||= Celerity::Browser.new @browser_options || {}
    end
    
    def target(object_id)
      if object_id == 'browser'
        browser
      elsif object_id == 'celerity'
        self
      else
        @proxies[object_id]
      end
    end
    
    def proxify(result)
      if result.is_a?(Array)
        result.map {|x| proxify(x) }.inspect
      elsif [String, TrueClass, FalseClass, Fixnum, Float, NilClass].include?(result.class)
        result.inspect
      else
        @proxies[result.object_id] = result
        "Culerity::RemoteObjectProxy.new(#{result.object_id}, @io)"
      end
    end
  end
end