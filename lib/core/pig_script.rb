class PigScript
    
  attr_accessor :options
    
  def initialize script
    @script = script
  end

  def run mode
    puts local_cmd
    IO.popen(local_cmd) do |io|
      while line = io.gets do
        $stderr.puts line unless options[:quiet]
      end
    end
  end

  def local_cmd
    "#{pig} -x local -l log #{pig_args(@options)} #{@script}"
  end

  def cmd
    "#{pig} -l /tmp #{pig_args(@options)} #{@script}"
  end
    
  def pig
    "#{PigPublicTransportation.root}/vendor/pig-0.10.0/bin/pig"
  end
    
  def pig_args options
    options.reduce("") {|args, (k,v)|
       args << "-p #{k.upcase}=#{v} "
    }
  end

end
