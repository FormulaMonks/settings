require "yaml"

module Settings
  VERSION = "0.0.4"
  
  def self.extended(base)
    base.instance_variable_set "@_settings", Hash.new(File.join(Dir.pwd, "config", "settings.yml"), ENV["RACK_ENV"])
  end
  
  def setting(key)
    @_settings[key]
  end

  class Hash < ::Hash
    # Raised when attempting to access a key which has not been set.
    class SettingNotFound < StandardError;end;

    # Creates a new Settings::Hash from a YAML file located at the given path.
    # 
    # Optionally loads only the settings within the given namespace (if a
    # namespace is given)
    # 
    #     Settings::Hash.new('/path/to/settings.yml')       => { 'foo' => { :bar => 'baz' }, :bam => 'bang' }
    #     Settings::Hash.new('/path/to/settings.yml, 'foo') => { :bar => 'baz' }
    # 
    def initialize(path, namespace=nil)
      begin
        settings = YAML.load_file(path)
      rescue Errno::ENOENT => e
        e.message << " (attempting to load settings file)"
        raise e
      end

      if namespace
        raise "No settings defined for #{namespace} in settings file: #{path}" unless settings[namespace]
        settings = settings[namespace]
      end

      update settings
      freeze
    end

    # Access the value at the given key, raises Settings::Hash::SettingNotFound
    # if the key is not set.
    def [](key)
      raise SettingNotFound.new("No setting found for #{key.inspect}") unless has_key?(key)
      super
    end
  end
end
