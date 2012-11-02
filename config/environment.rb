require 'java'

class PigPublicTransportation 
  class << self
    def root
      File.expand_path('../..', __FILE__)
    end
  end
end

# register all require paths
$: << File.expand_path(PigPublicTransportation.root + '/lib',  __FILE__)

# contains persistent jar files
$: << File.expand_path(PigPublicTransportation.root + '/lib/java',  __FILE__)

require 'core/pig_script'
#require 'hadoop-common-0.23.4.jar'

# export the jruby jar
jruby_jar = "#{PigPublicTransportation.root}/lib/java/jruby-complete-1.7.0.jar"
ENV['PIG_CLASSPATH']=jruby_jar
