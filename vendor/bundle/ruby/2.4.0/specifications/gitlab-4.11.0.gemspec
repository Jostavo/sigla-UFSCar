# -*- encoding: utf-8 -*-
# stub: gitlab 4.11.0 ruby lib

Gem::Specification.new do |s|
  s.name = "gitlab".freeze
  s.version = "4.11.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nihad Abbasov".freeze, "Sean Edge".freeze]
  s.bindir = "exe".freeze
  s.date = "2019-04-23"
  s.description = "Ruby client and CLI for GitLab API".freeze
  s.email = ["nihad@42na.in".freeze, "asedge@gmail.com".freeze]
  s.executables = ["gitlab".freeze]
  s.files = ["exe/gitlab".freeze]
  s.homepage = "https://github.com/NARKOZ/gitlab".freeze
  s.licenses = ["BSD-2-Clause".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3".freeze)
  s.rubygems_version = "2.6.14".freeze
  s.summary = "A Ruby wrapper and CLI for the GitLab API".freeze

  s.installed_by_version = "2.6.14" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>.freeze, [">= 0.14.0", "~> 0.14"])
      s.add_runtime_dependency(%q<terminal-table>.freeze, [">= 1.5.1", "~> 1.5"])
      s.add_development_dependency(%q<pry>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<rubocop>.freeze, [">= 0"])
      s.add_development_dependency(%q<webmock>.freeze, [">= 0"])
    else
      s.add_dependency(%q<httparty>.freeze, [">= 0.14.0", "~> 0.14"])
      s.add_dependency(%q<terminal-table>.freeze, [">= 1.5.1", "~> 1.5"])
      s.add_dependency(%q<pry>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<rubocop>.freeze, [">= 0"])
      s.add_dependency(%q<webmock>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<httparty>.freeze, [">= 0.14.0", "~> 0.14"])
    s.add_dependency(%q<terminal-table>.freeze, [">= 1.5.1", "~> 1.5"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop>.freeze, [">= 0"])
    s.add_dependency(%q<webmock>.freeze, [">= 0"])
  end
end
