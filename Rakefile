require 'rake'
require 'spec/rake/spectask'
require 'rake/rdoctask'

begin
  require 'rubygems' unless ENV['NO_RUBYGEMS']
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

desc "Run all unit specs"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = FileList['spec/*_spec.rb']
end

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Culerity'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

task :default => :spec
