require File.join(File.expand_path(File.dirname(__FILE__)), '../config/environment')
require 'configliere'

Settings.use :commandline
Settings.define 'script', :default => 'script.pig'



Settings.define :input, :default => 'in'
Settings.define :output, :default => 'out'

Settings.define(:options, {
  :required   => true,
  :default => {
    :jarpath => File.join(PigPublicTransportation.root, 'lib', 'java'),
    :jruby   => File.join(PigPublicTransportation.root, 'lib', 'udf', 'ruby')
  }
})

Settings.resolve!

script = PigScript.new(Settings.script)
script.options = Settings.options.update( :input => Settings.input, :output => Settings.output )
script.run(:local)
