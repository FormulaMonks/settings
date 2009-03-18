Gem::Specification.new do |s|
  s.name = 'settings'
  s.version = '0.0.1'
  s.summary = %{}
  s.date = %q{2009-03-17}
  s.author = "Ben Alavi"
  s.email = "ben.alavi@citrusbyte.com"
  s.homepage = "http://github.com/citrusbyte/settings"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.files = ["lib/settings_hash.rb", "lib/readonly_hash", "README.markdown", "LICENSE", "Rakefile", "test/settings_test.rb"]

  s.require_paths = ['lib']

  s.has_rdoc = false
end

