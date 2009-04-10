require 'rubygems'
require 'rake'
require 'echoe'
require 'rake/rdoctask'

Echoe.new("sentinel", "0.1.2") do |p|
  p.description = "Simple authorization for Rails"
  p.url = "http://github.com/joshuaclayton/sentinel"
  p.author = "Joshua Clayton"
  p.email = "joshua.clayton@gmail.com"
  p.ignore_pattern = ["tmp/*"]
  p.development_dependencies = ["actionpack >= 2.1.0", "activesupport >= 2.1.0"]
end

desc 'Generate documentation for the sentinel plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Sentinel'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end