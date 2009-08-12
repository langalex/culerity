Given /^a Rails app$/ do
  FileUtils.chdir(@tmp_root) do
    `rails my_project`
  end
  @active_project_folder = File.expand_path(File.join(@tmp_root, "my_project"))
end

Given /^I copy the project generators into "([^\"]*)"$/ do |target_folder|
  in_project_folder do
    FileUtils.mkdir_p(target_folder)
  end
  `cp -rf #{File.dirname(__FILE__) + "/../../generators/*"} #{File.join(@active_project_folder, target_folder)}`
end

When /^I add a feature file to test Rails index.html default file$/ do
  sample_feature = File.expand_path(File.dirname(__FILE__) + "/../fixtures/sample_feature")
  in_project_folder do
    `cp -rf #{sample_feature} features/sample.feature`
  end
end

Given /^I run the rails server in environment "([^\"]*)"$/ do |environment|
  in_project_folder do
    $rails_server ||= IO.popen("script/server -e #{environment} -p 3001", 'r+')
    File.open("tmp/culerity_rails_server.pid", "w") { |file| file << $rails_server.pid; file.flush }
  end
end

After do
  in_project_folder do
    pid = File.read("tmp/culerity_rails_server.pid").to_i
    Process.kill(6, $rails_server.pid) if $rails_server
  end
end

# rake culerity:rails:start [RAILS=culerity_development]
# rake culerity:rails:stop