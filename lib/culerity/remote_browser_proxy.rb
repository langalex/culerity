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
    
    # 
    # Calls the block until it returns true or +time_to_wait+ is reached.
    # +time_to_wait+ is 30 seconds by default
    # 
    # Returns true upon success
    # Raises Timeout::Error when +time_to_wait+ is reached.
    # 
    def wait_until time_to_wait=30, &block
      Timeout.timeout(time_to_wait) do
        until block.call
          sleep 0.1
        end
      end
      true
    end
    
    # 
    # Calls the block until it doesn't return true or +time_to_wait+ is reached.
    # +time_to_wait+ is 30 seconds by default
    # 
    # Returns true upon success
    # Raises Timeout::Error when +time_to_wait+ is reached.
    # 
    def wait_while time_to_wait=30, &block
      Timeout.timeout(time_to_wait) do
        while block.call
          sleep 0.1
        end
      end
      true
    end
    
    private
    
    def remote_object_id
      (@remote_object_id || 'browser').inspect
    end
  end
  
end