require 'yaml'

class Hash
  # From ActiveSupport lib/active_support/core_ext/hash/keys.rb line 22-27
  # Altered to recursively symbolize all keys in nested hashes
  def symbolize_keys
    inject({}) do |options, (key, value)|
      options[(key.to_sym rescue key) || key] = (value.is_a?(Hash) ? value.symbolize_keys : value)
      options
    end
  end
end

# A very simple "readonly" hash implementation. Freezes itselfs on
# initialization so that any attempts to change will result in a TypeError
class ReadonlyHash < Hash  
  class << self
    def [](*args)
      new(super(*args))
    end
  end
  
  def initialize(hash)
    update hash
    freeze
  end
end

class SettingsHash < ReadonlyHash
  # Raised when attempting to access a key which has not been set.
  class SettingNotFound < StandardError;end;
  
  # Creates a new SettingsHash from a YAML file located at the given path.
  # 
  # Optionally loads only the settings within the given namespace (if a
  # namespace is given)
  # 
  #     SettingsHash.new('/path/to/settings.yml')       => { :foo => { 'bar' => 'baz' }, :bam => 'bang' }
  #     SettingsHash.new('/path/to/settings.yml, 'foo') => { :bar => 'baz' }
  # 
  # Note that top-level keys are symbolized (as seen in example above)
  def initialize(path, namespace=nil)
    raise "No settings file found: #{path}" unless File.exists?(path)
    settings = YAML.load_file(path)
    
    if namespace
      raise "No settings defined for #{namespace} in settings file: #{path}" unless settings[namespace]
      settings = settings[namespace]
    end
    
    super(settings.symbolize_keys)
  end
  
  # Access the value at the given key, raises SettingsHash::SettingNotFound if
  # the key is not set.
  def [](key)
    raise SettingNotFound.new("No setting found for #{key}") unless has_key?(key)
    super
  end
end
