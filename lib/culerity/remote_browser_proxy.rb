module Culerity

  class RemoteBrowserProxy < RemoteObjectProxy
    def initialize(io)
      @io = io
    end
    
    private
    
    def remote_object_id
      '"browser"'
    end
  end
  
end