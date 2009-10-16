require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Culerity, 'run_rails' do
  before(:each) do
    Kernel.stub!(:sleep)
    IO.stub!(:popen)
    Culerity.stub!(:sleep)
  end
  
  it "should not run rails if we are not using rails" do
    IO.should_not_receive(:popen)
    Culerity.run_rails :port => 4000, :environment => 'culerity'
  end
  
  it "should run rails with default values" do
    Rails ||= :rails
    IO.should_receive(:popen).with("script/server -e culerity_development -p 3001", 'r+')
    Culerity.run_rails
  end
  
  it "should run rails with the given values" do
    Rails ||= :rails
    IO.should_receive(:popen).with("script/server -e culerity -p 4000", 'r+')
    Culerity.run_rails :port => 4000, :environment => 'culerity'
    
  end
  
  it "should wait for the server to start up" do
    Rails ||= :rails
    Culerity.should_receive(:sleep)
    Culerity.run_rails :port => 4000, :environment => 'culerity'
  end
end