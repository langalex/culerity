require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Culerity, 'run_rails' do
  before(:each) do
    Kernel.stub!(:sleep)
    IO.stub!(:popen)
    Culerity.stub!(:fork).and_yield.and_return(3200)
    Culerity.stub!(:exec)
    Culerity.stub!(:sleep)
    [$stdin, $stdout, $stderr].each{|io| io.stub(:reopen)}
  end
  
  it "should not run rails if we are not using rails" do
    Culerity.should_not_receive(:exec)
    Culerity.run_rails :port => 4000, :environment => 'culerity'
  end
  
  it "should run rails with default values" do
    Rails ||= stub(:rails, :root => Dir.pwd)
    Culerity.should_receive(:exec).with("script/server -e culerity -p 3001")
    Culerity.run_rails
  end
  
  it "should run rails with the given values" do
    Rails ||= stub(:rails, :root => Dir.pwd)
    Culerity.should_receive(:exec).with("script/server -e culerity -p 4000")
    Culerity.run_rails :port => 4000, :environment => 'culerity'
  end

  it "should change into the rails root directory" do
    Rails ||= stub(:rails, :root => Dir.pwd)
    Dir.should_receive(:chdir).with(Dir.pwd)
    Culerity.run_rails :port => 4000, :environment => 'culerity'
  end
  
  it "should wait for the server to start up" do
    Rails ||= stub(:rails, :root => Dir.pwd)
    Culerity.should_receive(:sleep)
    Culerity.run_rails :port => 4000, :environment => 'culerity'
  end
  
  it "should reopen the i/o channels to /dev/null" do
    Rails ||= stub(:rails, :root => Dir.pwd)
    [$stdin, $stdout, $stderr].each{|io| io.should_receive(:reopen).with("/dev/null")}
    Culerity.run_rails :port => 4000, :environment => 'culerity'
  end
end