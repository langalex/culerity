require 'rubygems'
require 'celerity'


module Culerity
  class CelerityServer
    
    def initialize(_in, _out)
      @proxies = {}
      @browsers = []

      while(true)
        call = eval _in.gets.to_s.strip
        return if call == ["_exit_"]
        next(close_browsers) if call == ["_close_browsers_"]
        unless call.nil?
          begin
            # check if last arg is a block
            if call.last.is_a?(Proc)
              # pass as &call[-1]
              result = target(call.first).send call[1], *call[2..-2], &call[-1]
            else
              # just call with args as normal
              result = target(call.first).send call[1], *call[2..-1]
            end
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
    
    def new_browser(options, number = nil)
      number ||= @browsers.size
      @browsers[number] = Celerity::Browser.new(options || @browser_options || {})
      "browser#{number}"
    end

    def close_browsers
      @browsers.each { |browser| browser.close }
      @browsers = []
    end

    def browser(number)
      unless @browsers[number]
        new_browser(nil, number)
      end
      @browsers[number]
    end
    
    def target(object_id)
      if object_id =~ /browser(\d+)/
        browser($1.to_i)
      elsif object_id == 'celerity'
        self
      else
        @proxies[object_id]
      end
    end
    
    def proxify(result)
      if result.is_a?(Array)
        "[" + result.map {|x| proxify(x) }.join(", ") + "]"
      elsif [String, TrueClass, FalseClass, Fixnum, Float, NilClass].include?(result.class)
        result.inspect
      else
        @proxies[result.object_id] = result
        "Culerity::RemoteObjectProxy.new(#{result.object_id}, @io)"
      end
    end
  end
end
