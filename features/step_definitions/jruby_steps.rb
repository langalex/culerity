Given /^I have jruby installed$/ do
  @jruby_cmd = `which jruby`.strip
end

Given /^I do not have jruby installed$/ do
  @jruby_cmd = ""
end

Then /^the gem "([^\"]*)" is installed into jruby environment$/ do |gem_name|
  raise "Need to setup @jruby_cmd to test jruby environment" if @jruby_cmd.blank?
  gem_list = `#{@jruby_cmd} -S gem list celerity`
  gem_list.should =~ /#{gem_name}/
end

