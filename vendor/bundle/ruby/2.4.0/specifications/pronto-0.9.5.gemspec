# -*- encoding: utf-8 -*-
# stub: pronto 0.9.5 ruby lib

Gem::Specification.new do |s|
  s.name = "pronto".freeze
  s.version = "0.9.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Mindaugas Moz\u016Bras".freeze]
  s.date = "2017-08-15"
  s.description = "    Pronto runs analysis quickly by checking only the relevant changes. Created\n    to be used on pull requests, but suited for other scenarios as well. Perfect\n    if you want to find out quickly if branch introduces changes that conform to\n    your styleguide, are DRY, don't introduce security holes and more.\n".freeze
  s.email = "mindaugas.mozuras@gmail.com".freeze
  s.executables = ["pronto".freeze]
  s.extra_rdoc_files = ["LICENSE".freeze, "README.md".freeze]
  s.files = ["LICENSE".freeze, "README.md".freeze, "bin/pronto".freeze]
  s.homepage = "https://github.com/prontolabs/pronto".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)
  s.rubygems_version = "2.6.14".freeze
  s.summary = "Pronto runs analysis by checking only the introduced changes".freeze

  s.installed_by_version = "2.6.14" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rugged>.freeze, [">= 0.23.0", "~> 0.24"])
      s.add_runtime_dependency(%q<thor>.freeze, ["~> 0.19.0"])
      s.add_runtime_dependency(%q<octokit>.freeze, [">= 4.7.0", "~> 4.7"])
      s.add_runtime_dependency(%q<gitlab>.freeze, [">= 4.0.0", "~> 4.0"])
      s.add_runtime_dependency(%q<httparty>.freeze, [">= 0.13.7"])
      s.add_runtime_dependency(%q<rainbow>.freeze, ["~> 2.1"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 12.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.4"])
      s.add_development_dependency(%q<rspec-its>.freeze, ["~> 1.2"])
      s.add_development_dependency(%q<rspec-expectations>.freeze, ["~> 3.4"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.14"])
      s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.47"])
      s.add_development_dependency(%q<pronto-rubocop>.freeze, ["~> 0.9.0"])
      s.add_development_dependency(%q<codeclimate-test-reporter>.freeze, ["~> 1.0"])
    else
      s.add_dependency(%q<rugged>.freeze, [">= 0.23.0", "~> 0.24"])
      s.add_dependency(%q<thor>.freeze, ["~> 0.19.0"])
      s.add_dependency(%q<octokit>.freeze, [">= 4.7.0", "~> 4.7"])
      s.add_dependency(%q<gitlab>.freeze, [">= 4.0.0", "~> 4.0"])
      s.add_dependency(%q<httparty>.freeze, [">= 0.13.7"])
      s.add_dependency(%q<rainbow>.freeze, ["~> 2.1"])
      s.add_dependency(%q<rake>.freeze, ["~> 12.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.4"])
      s.add_dependency(%q<rspec-its>.freeze, ["~> 1.2"])
      s.add_dependency(%q<rspec-expectations>.freeze, ["~> 3.4"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_dependency(%q<simplecov>.freeze, ["~> 0.14"])
      s.add_dependency(%q<rubocop>.freeze, ["~> 0.47"])
      s.add_dependency(%q<pronto-rubocop>.freeze, ["~> 0.9.0"])
      s.add_dependency(%q<codeclimate-test-reporter>.freeze, ["~> 1.0"])
    end
  else
    s.add_dependency(%q<rugged>.freeze, [">= 0.23.0", "~> 0.24"])
    s.add_dependency(%q<thor>.freeze, ["~> 0.19.0"])
    s.add_dependency(%q<octokit>.freeze, [">= 4.7.0", "~> 4.7"])
    s.add_dependency(%q<gitlab>.freeze, [">= 4.0.0", "~> 4.0"])
    s.add_dependency(%q<httparty>.freeze, [">= 0.13.7"])
    s.add_dependency(%q<rainbow>.freeze, ["~> 2.1"])
    s.add_dependency(%q<rake>.freeze, ["~> 12.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.4"])
    s.add_dependency(%q<rspec-its>.freeze, ["~> 1.2"])
    s.add_dependency(%q<rspec-expectations>.freeze, ["~> 3.4"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.14"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.47"])
    s.add_dependency(%q<pronto-rubocop>.freeze, ["~> 0.9.0"])
    s.add_dependency(%q<codeclimate-test-reporter>.freeze, ["~> 1.0"])
  end
end
