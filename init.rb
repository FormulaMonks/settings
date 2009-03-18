require 'settings_hash'
Settings = SettingsHash.new(File.join(Rails.root, 'config', 'settings.yml'), Rails.env)