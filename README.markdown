Settings
========

A special hash for application-wide settings.

Description
-----------

Small and simple specialized Hash which is helpful for storing immutable,
required key/value pairs to be loaded from a YAML file.

New instances of @SettingsHash@ are readonly -- any attempt to write to the
Hash after initialization will fail with a @TypeError@.

Any attempt to read a key which is not set will raise a 
@SettingsHash::SettingMissing@ error.

@SettingsHash@ supports an optional namespace which can be used to define
multiple groups of settings within a single .yml file. For example, "test" and
"development" might be different namespaces for different running environments.

Usage
-----

== General

    settings = SettingsHash.new('path/to/settings.yml')
    settings = SettingsHash.new('path/to/settings.yml', 'foo') => loads settings under the 'foo' namespace
    
== Rails

Put your environment-specific @settings.yml@ in @config/settings.yml@. It may
look something like this:

    development:
      memcached: true
    test:
      memcached: false
      
This file will automatically be loaded into a @Settings@ global which can be
accessed like a normal Hash:

    Settings[:memcached] => true (development environment)
    Settings[:memcached] => false (test environment)
    
Rails Usage
-----------

Installation
------------

    $ gem sources -a http://gems.github.com (you only have to do this once)
    $ sudo gem install citrusbyte-settings_hash

License
-------

Copyright (c) 2009 Ben Alavi for Citrusbyte

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
