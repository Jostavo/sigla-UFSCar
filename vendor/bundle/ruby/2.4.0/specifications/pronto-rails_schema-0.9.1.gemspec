# -*- encoding: utf-8 -*-
# stub: pronto-rails_schema 0.9.1 ruby lib

Gem::Specification.new do |s|
  s.name = "pronto-rails_schema".freeze
  s.version = "0.9.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Raimondas Valickas".freeze]
  s.bindir = "exe".freeze
  s.date = "2018-04-06"
  s.description = "Detects migration files and checks for changes in\n    schema.rb or structure.sql files".freeze
  s.email = ["raimondas@vinted.com".freeze]
  s.homepage = "https://github.com/raimondasv/pronto-schema_check".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)
  s.rubygems_version = "2.6.14".freeze
  s.summary = "Pronto runner for detection of Rails schema changes.".freeze

  s.installed_by_version = "2.6.14" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<pronto>.freeze, ["~> 0.9.0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.10"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.3"])
    else
      s.add_dependency(%q<pronto>.freeze, ["~> 0.9.0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.10"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.3"])
    end
  else
    s.add_dependency(%q<pronto>.freeze, ["~> 0.9.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.10"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.3"])
  end
end
