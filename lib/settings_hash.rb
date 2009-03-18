require 'readonly_hash'
require 'yaml'

class SettingsHash < ReadonlyHash
  class SettingMissing < StandardError;end;
  
  def initialize(path, namespace=nil)
    raise "No settings file found: #{path}" unless File.exists?(path)
    settings = YAML.load_file(path)
    
    if namespace
      raise "No settings defined for #{namespace} in settings file: #{path}" unless settings[namespace]
      settings = settings[namespace]
    end
    
    super(settings.symbolize_keys)
  end
  
  def [](key)
    raise SettingMissing.new("No setting found for #{key}") unless has_key?(key)
    super
  end
end

class Hash
  # from ActiveSupport
  # lib/active_support/core_ext/hash/keys.rb line 22-27
  def symbolize_keys
    inject({}) do |options, (key, value)|
      options[(key.to_sym rescue key) || key] = value
      options
    end
  end
end
