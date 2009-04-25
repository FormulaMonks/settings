# Rails-specific initialization, only here because if you try to set a global
# constant in init.rb it gets removed, but if you require a file that sets a
# global constant it seems to work -- not sure why?
# 
# Also, Rails gem-dependencies expect a file with the name of the gem in lib
# that defines a constant with the same name -- hence we have to file called
# settings.rb which defines Settings for Rails to be happy =)
require 'settings_hash'
Settings = SettingsHash.new(File.join(Rails.root, 'config', 'settings.yml'), Rails.env)