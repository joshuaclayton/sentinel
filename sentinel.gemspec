# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sentinel}
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Joshua Clayton"]
  s.date = %q{2009-04-10}
  s.description = %q{Simple authorization for Rails}
  s.email = %q{joshua.clayton@gmail.com}
  s.extra_rdoc_files = ["lib/sentinel/controller.rb", "lib/sentinel/sentinel.rb", "lib/sentinel.rb", "README.textile"]
  s.files = ["lib/sentinel/controller.rb", "lib/sentinel/sentinel.rb", "lib/sentinel.rb", "Manifest", "MIT-LICENSE", "rails/init.rb", "Rakefile", "README.textile", "sentinel.gemspec", "shoulda_macros/sentinel.rb", "test/functional/sentinel_controller_test.rb", "test/partial_rails/controllers/application_controller.rb", "test/partial_rails/controllers/forums_controller.rb", "test/partial_rails/forum_sentinel.rb", "test/test_helper.rb", "test/unit/sentinel_test.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/joshuaclayton/sentinel}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Sentinel", "--main", "README.textile"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{sentinel}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Simple authorization for Rails}
  s.test_files = ["test/functional/sentinel_controller_test.rb", "test/test_helper.rb", "test/unit/sentinel_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<actionpack>, [">= 0", "= 2.1.0"])
      s.add_development_dependency(%q<activesupport>, [">= 0", "= 2.1.0"])
    else
      s.add_dependency(%q<actionpack>, [">= 0", "= 2.1.0"])
      s.add_dependency(%q<activesupport>, [">= 0", "= 2.1.0"])
    end
  else
    s.add_dependency(%q<actionpack>, [">= 0", "= 2.1.0"])
    s.add_dependency(%q<activesupport>, [">= 0", "= 2.1.0"])
  end
end
