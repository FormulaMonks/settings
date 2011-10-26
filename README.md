Settings
========

A special hash for application-wide settings.

Description
-----------

Small and simple specialized Hash which is helpful for storing immutable,
required key/value pairs to be loaded from a YAML file.

New instances of `Settings::Hash` are readonly -- any attempt to write to the
Hash after initialization will fail with a `TypeError`. This way you can avoid
inadvertently altering the expected value of a setting at runtime.

Any attempt to read a key which is not set will raise a 
`Settings::Hash::SettingNotFound` error. This way expected values will raise when
expected, making them easier to track down than if they had silently returned
`nil`.

`Settings::Hash` supports an optional namespace which can be used to define
multiple groups of settings within a single .yml file. Commonly this can be
used to define per-environment settings, i.e. "test" and "development".

Finally, there is a small module which you can use in your Rack applications to
provide some sensible defaults for loading a settings file.

Usage
-----

`config/settings.yml`
    
    test:
      :foo: 123456
    development:
      :foo: "abcdef"

### Settings::Hash

    settings = Settings::Hash.new("config/settings.yml")
    settings["test"][:foo] #=> 123456
    settings["development"][:foo] #=> "abcdef"
    
    settings = Settings::Hash.new("config/settings.yml", "test")
    settings[:foo] #=> 123456
    
    ENV["RACK_ENV"] = "development"
    settings = Settings::Hash.new("config/settings.yml", ENV["RACK_ENV"])
    settings[:foo] #=> "abcdef"

### Cuba

    Cuba.extend Settings
    
    Cuba.define do
      on "/" do
        res.write Cuba.setting(:foo) #=> "abcdef"
      end
    end

### Sinatra
  
    class MyApplication < Sinatra::Base
      extend Settings
      
      get "/" do
        MyApplication.setting(:foo) #=> "abcdef"
      end
    end

### Rails
    
    gem "settings", "0.0.4" # (in `Gemfile`)
    
    Rails.extend Settings # (in `config/initializers/settings.rb`)
    
    class WidgetController < ActionController::Base
      def index
        Rails.setting("foo") #=> "abcdef"
      end
    end

Installation
------------

    $ sudo gem install settings

Test
----

    $ rake

Changelog
---------

### 0.0.4

Settings no longer symbolizes keys. If you want to use symbols for keys, define
your keys as symbols in your `.yml` file, i.e.:

    :test:
      :alphabet: "abcdef"

instead of:

    test:
      alphabet: "abcdef"

Settings no longer explicitly supports Rails -- instead it comes with some
defaults for Rack applications which could be used with Rails.

License
-------

Copyright (c) 2009-2011 Ben Alavi for Citrusbyte

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
