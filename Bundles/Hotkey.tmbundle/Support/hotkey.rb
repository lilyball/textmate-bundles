#!/usr/bin/env ruby

require 'optparse'
require 'yaml'

module HotKey
  
  def HotKey.get_options()
    options = Hash.new()
    
    opts = OptionParser.new() { |opts|
      opts.on("-c", "--config FILENAME", "Configuration file") { |filename| 
        options["config"] = filename
      }
      
      opts.on("-n", "--key-number NUM", Integer, "Number of the key to run") { |num|
        options["num"] = num
      }
      
      opts.on("-u", "--update COMMAND", "Update --key-number with COMMAND") { |command|
        options["command"] = command
      }
      
      opts.on("-C", "--check", "Check if num command is specified") {
        options["check"] = true
      }
      
			opts.on_tail("-h", "--help", "Print this message") {
				print(opts)
				exit()
			}
		}
			
		opts.parse(ARGV)
		
		if(options["config"] == nil)
		  $stderr.print("Configuration file must be given")
		  exit!(1)
	  end

		return(options)
  end
  
  
  def HotKey.get_config(filename)
    return(YAML.load_file(filename))
  end


  def HotKey.run(num)
    print `#{@config[num]}`
  end
  
  
  # Updates command number +num+ to be +command+
  def HotKey.update(command, num, configfile)
    @config[num] = command
    File.open(configfile, File::CREAT|File::TRUNC|File::WRONLY) { |fp|
      fp.write(@config.to_yaml)
    }
  end
  
  
  def HotKey.main()
    options = get_options()
    
    if(!File.exists?(options["config"]))
      @config = Hash.new()
    else
      @config = get_config(options["config"])
    end
    
    if(options["check"])
      if(@config.has_key?(options["num"]))
        exit(0)
      else
        exit(100)
      end
    elsif(options["command"])
      update(options["command"], options["num"], options["config"])
    else
      run(options["num"])
    end
  end
  
end

HotKey.main()