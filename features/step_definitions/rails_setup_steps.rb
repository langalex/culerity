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

