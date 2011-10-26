require File.expand_path("lib/settings", File.dirname(__FILE__))

Gem::Specification.new do |s|
  s.name = "settings"
  s.version = Settings::VERSION
  s.summary = "A special hash for application-wide settings"
  s.description = "Small and simple specialized Hash which is helpful for storing immutable, required key/value pairs to be loaded from a YAML file."
  s.date = "2011-10-25"
  s.authors = ["Ben Alavi"]
  s.email = ["ben.alavi@citrusbyte.com"]
  s.homepage = "http://github.com/citrusbyte/settings"

  s.files = Dir[
    "README.md",
    "rakefile",
    "settings.gemspec",
    "lib/**/*.rb",
    "test/**/*.rb",
    "test/fixtures/*.yml"
  ]

  s.add_development_dependency "contest"
end
