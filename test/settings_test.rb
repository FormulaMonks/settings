$: << File.expand_path("../lib", File.dirname(__FILE__))

require "rubygems"
require "test/unit"
require "contest"
require "settings"

def fixture_path
  File.join(File.dirname(__FILE__), "fixtures")
end

class Application
end

class Widget
end

class SettingsTest < Test::Unit::TestCase
  should "return hash of all settings when no namespace is present" do
    assert_equal({ :foo => "bar" }, Settings::Hash.new(File.join(fixture_path, "no_namespace.yml")))
  end

  should "load all settings" do
    settings = Settings::Hash.new File.join(fixture_path, "settings.yml")
    assert_equal({ "test" => { :foo => "bar", "abc" => { "def" => 123 } } }, settings)
  end

  should "only load settings in given namespace" do
    settings = Settings::Hash.new(File.join(fixture_path, "settings.yml"), "test")
    assert_equal({ :foo => "bar", "abc" => { "def" => 123 } }, settings)
  end
  
  should "raise when attempting to change a setting" do
    settings = Settings::Hash.new File.join(fixture_path, "settings.yml")
    assert_raise TypeError do
      settings[:foo] = "baz"
    end
  end
  
  should "raise when attempting to add a setting" do
    settings = Settings::Hash.new File.join(fixture_path, "settings.yml")
    assert_raise TypeError do
      settings[:bar] = "bam"
    end
  end
  
  should "raise if key is not set" do
    settings = Settings::Hash.new File.join(fixture_path, "settings.yml")
    assert_raise Settings::Hash::SettingNotFound do
      settings[:bar]
    end
  end

  should "raise when settings file does not exist" do
    assert_raise Errno::ENOENT do
      Settings::Hash.new(File.join(fixture_path, "missing.yml"))
    end
  end

  should "raise when namespace doesn't exit" do
    assert_raise RuntimeError do
      Settings::Hash.new(File.join(fixture_path, 'settings.yml'), "foo")
    end
  end
  
  should "load settings from config/settings.yml when extended" do
    ENV["RACK_ENV"] = "test"
    
    FileUtils.rm "config/settings.yml"
    FileUtils.rmdir "config"
    FileUtils.mkdir "config"
    FileUtils.cp "test/fixtures/settings.yml", "config/settings.yml"
    
    assert !Application.respond_to?(:setting)
    
    Application.send :extend, Settings
    assert_equal "bar", Application.setting(:foo)
  end
end
