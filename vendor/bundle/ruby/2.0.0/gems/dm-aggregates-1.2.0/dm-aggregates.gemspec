# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "dm-aggregates"
  s.version = "1.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Foy Savas"]
  s.date = "2011-10-09"
  s.description = "DataMapper plugin providing support for aggregates on collections"
  s.email = "foysavas [a] gmail [d] com"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "Gemfile",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "dm-aggregates.gemspec",
    "lib/dm-aggregates.rb",
    "lib/dm-aggregates/adapters/dm-do-adapter.rb",
    "lib/dm-aggregates/aggregate_functions.rb",
    "lib/dm-aggregates/collection.rb",
    "lib/dm-aggregates/core_ext/symbol.rb",
    "lib/dm-aggregates/functions.rb",
    "lib/dm-aggregates/model.rb",
    "lib/dm-aggregates/operators.rb",
    "lib/dm-aggregates/query.rb",
    "lib/dm-aggregates/repository.rb",
    "spec/isolated/require_after_setup_spec.rb",
    "spec/isolated/require_before_setup_spec.rb",
    "spec/isolated/require_spec.rb",
    "spec/public/collection_spec.rb",
    "spec/public/model_spec.rb",
    "spec/public/shared/aggregate_shared_spec.rb",
    "spec/rcov.opts",
    "spec/spec.opts",
    "spec/spec_helper.rb",
    "tasks/spec.rake",
    "tasks/yard.rake",
    "tasks/yardstick.rake"
  ]
  s.homepage = "http://github.com/datamapper/dm-aggregates"
  s.require_paths = ["lib"]
  s.rubyforge_project = "datamapper"
  s.rubygems_version = "1.8.11"
  s.summary = "DataMapper plugin providing support for aggregates on collections"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<dm-core>, ["~> 1.2.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rake>, ["~> 0.9.2"])
      s.add_development_dependency(%q<rspec>, ["~> 1.3.2"])
    else
      s.add_dependency(%q<dm-core>, ["~> 1.2.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rake>, ["~> 0.9.2"])
      s.add_dependency(%q<rspec>, ["~> 1.3.2"])
    end
  else
    s.add_dependency(%q<dm-core>, ["~> 1.2.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rake>, ["~> 0.9.2"])
    s.add_dependency(%q<rspec>, ["~> 1.3.2"])
  end
end

