require File.dirname(__FILE__) + '/spec_helper'

describe Culerity::RemoteBrowserProxy do
  it "should send the serialized method call to the output" do
    io = stub 'io', :gets => '[return, :okay]'
    io.should_receive(:<<).with("[\"browser\", \"goto\", \"/homepage\"]\n")
    proxy = Culerity::RemoteBrowserProxy.new io
    proxy.goto '/homepage'
  end
  
  it "should return the deserialized return value" do
    io = stub 'io', :gets => "[:return, :okay]\n", :<< => nil
    proxy = Culerity::RemoteBrowserProxy.new io
    proxy.goto.should == :okay
  end
  
  it "should send the brower options to the remote server" do
    io = stub 'io', :gets => "[:return, :okay]"
    io.should_receive(:<<).with('["celerity", "configure_browser", {:browser=>:firefox}]' + "\n")
    proxy = Culerity::RemoteBrowserProxy.new io, {:browser => :firefox}
  end
  
end