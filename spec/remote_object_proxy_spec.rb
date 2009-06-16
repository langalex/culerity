require File.dirname(__FILE__) + '/spec_helper'

describe Culerity::RemoteObjectProxy do
  it "should send the serialized method call to the output" do
    io = stub 'io', :gets => '[:return]'
    io.should_receive(:<<).with(%Q{[345, "goto", "/homepage"]\n})
    proxy = Culerity::RemoteObjectProxy.new 345, io
    proxy.goto '/homepage'
  end
  
  it "should return the deserialized return value" do
    io = stub 'io', :gets => "[:return, :okay]\n", :<< => nil
    proxy = Culerity::RemoteObjectProxy.new 345, io
    proxy.goto.should == :okay
  end
  
  it "should raise the received exception" do
    io = stub 'io', :gets => %Q{[:exception, "RuntimeError", "test exception", []]}, :<< => nil
    proxy = Culerity::RemoteObjectProxy.new 345, io
    lambda {
      proxy.goto '/home'
    }.should raise_error(Culerity::CulerityException)
  end
  
  it "should send exit" do
    io = stub 'io', :gets => '[:return]'
    io.should_receive(:<<).with('["_exit_"]')
    proxy = Culerity::RemoteObjectProxy.new 345, io
    proxy.exit
  end
end