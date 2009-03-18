require 'test/unit'
require 'rubygems'
require 'contest'
require File.dirname(__FILE__) + "/../lib/settings_hash"

def fixture_path
  File.join(File.dirname(__FILE__), 'fixtures')
end

class SettingsTest < Test::Unit::TestCase
  context "settings file exists" do
    context "and has values" do
      context "in test namespace" do
        context "and namespace exists" do
          setup do
            @settings = SettingsHash.new(File.join(fixture_path, 'settings.yml'), 'test')
          end
      
          test "should return hash of settings" do
            assert_equal({ :foo => 'bar' }, @settings)
          end
    
          test "should freeze settings" do
            assert_raise TypeError do
              @settings[:foo] = 'baz'
            end
          end
      
          test "should raise if key is not set" do
            assert_raise SettingsHash::SettingMissing do
              @settings[:bar]
            end
          end
        end
        
        context "and namespace doesnt exist" do
          test "should raise" do
            assert_raise RuntimeError do
              SettingsHash.new(File.join(fixture_path, 'settings.yml'), 'foo')
            end
          end
        end
      end
            
      context "outside of test namespace" do
        test "should return hash of settings" do
          assert_equal({ :baz => 'bang' }, SettingsHash.new(File.join(fixture_path, 'no_namespace.yml')))
        end
      end
    end
  end
  
  context "settings file doesnt exist" do
    test "should raise" do
      assert_raise RuntimeError do
        SettingsHash.new(File.join(fixture_path, 'missing.yml'))
      end
    end
  end
end
