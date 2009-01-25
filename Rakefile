require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rcov/rcovtask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "culerity"
    s.summary = %Q{Culerity integrates Cucumber and Celerity in order to test your application's full stack.}
    s.email = "alex@upstream-berlin.com"
    s.homepage = "http://github.com/langalex/culerity"
    s.description = "Culerity integrates Cucumber and Celerity in order to test your application's full stack."
    s.authors = ["Alexander Lang"]
    s.add_dependency 'cucumber' 
    s.add_dependency 'rspec' 
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = 'spec/**/*_spec.rb'
  t.verbose = false
end

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Culerity'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Rcov::RcovTask.new do |t|
  t.libs << 'spec'
  t.test_files = FileList['spec/**/*_spec.rb']
  t.verbose = true
end

task :default => :test
