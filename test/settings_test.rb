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
      
          should "return hash of settings" do
            assert @settings.is_a?(SettingsHash)
          end
          
          should "symbolize keys" do
            assert @settings.has_key?(:foo)
          end
          
          should "symbolize nested keys" do
            assert @settings[:abc].has_key?(:def)
          end
          
          should "set nested values" do
            assert_equal 123, @settings[:abc][:def]
          end
          
          should "have bar for :foo" do
            assert_equal 'bar', @settings[:foo]
          end
          
          should "freeze settings" do
            assert_raise TypeError do
              @settings[:foo] = 'baz'
            end
          end
          
          should "return value for key if set" do
            assert_equal 'bar', @settings[:foo]
          end
      
          should "raise if key is not set" do
            assert_raise SettingsHash::SettingNotFound do
              @settings[:bar]
            end
          end
        end
        
        context "and namespace doesnt exist" do
          should "raise" do
            assert_raise RuntimeError do
              SettingsHash.new(File.join(fixture_path, 'settings.yml'), 'foo')
            end
          end
        end
      end
      
      context "outside of test namespace" do
        should "return hash of settings" do
          assert_equal({ :baz => 'bang' }, SettingsHash.new(File.join(fixture_path, 'no_namespace.yml')))
        end
      end
    end
  end
  
  context "settings file doesnt exist" do
    should "raise" do
      assert_raise RuntimeError do
        SettingsHash.new(File.join(fixture_path, 'missing.yml'))
      end
    end
  end
end
