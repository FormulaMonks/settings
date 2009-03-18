# Rails-specific initialization, only here because if you try to set a global
# constant in init.rb it gets removed, but if you require a file that sets a
# global constant it seems to work -- not sure why?
require 'settings_hash'
Settings = SettingsHash.new(File.join(Rails.root, 'config', 'settings.yml'), Rails.env)