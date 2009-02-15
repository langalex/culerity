module Culerity

  class RemoteBrowserProxy < RemoteObjectProxy
    def initialize(io, browser_options = {})
      @io = io
      unless browser_options.empty?
        @remote_object_id = 'celerity'
        configure_browser browser_options 
        @remote_object_id = nil
      end
      
    end
    
    private
    
    def remote_object_id
      (@remote_object_id || 'browser').inspect
    end
  end
  
end