class Runner
  def self.target(dir = ".")
    if not File.exists? "#{dir}/Makefile"
      raise "No Makefile found in #{dir}."
    end

    if not File.readlines("#{dir}/Makefile").find { |i| i =~ /^TARGET\s+\=\s+([^\s][\w\.\/\s]+)\s*$/ }
      raise "Unable to find TARGET in #{dir}/Makefile."
    end

    $1
  end
  
  def self.__shell_escape(str)
    str.gsub(/[{}()`'"\\; $<>&]/, '\\\\\&')
  end

  # :no_terminal -- runs stand alone
  # :pre_cmd     -- command that runs prior to target
  # :post_cmd    -- runs after target
  def self.run(target, dir, options = {})
    dir  = __shell_escape(File.expand_path(dir))
    file = __shell_escape(target)
    env = "env DYLD_FRAMEWORK_PATH=#{dir} DYLD_LIBRARY_PATH=#{dir}"

    if options[:no_terminal]
      cmd = "cd #{dir}; #{env} open ./#{file}"
      %x{#{cmd}}
    else
      pre  = options[:pre_cmd]  || ""
      post = options[:post_cmd] || ""
      cmd  = "clear; cd #{dir}; #{pre}; #{env} ./#{file}; #{post};"
      cmd += "echo -ne \\\\n\\\\nPress RETURN to Continue...; read foo;"

      # Executes after target is terminated
      cmd += 'osascript &>/dev/null'
      cmd += ' -e "tell app \"TextMate\" to activate"'
      cmd += ' -e "tell app \"Terminal\" to close first window" &'

      # This is run before the first command finishes
      %x{osascript \
        -e 'tell app "Terminal"' \
        -e 'activate' \
        -e 'do script "#{cmd.gsub(/[\\"]/, '\\\\\\0')}"' \
        -e 'set position of first window to { 100, 100 }' \
        -e 'set custom title of first window to "#{file}"' \
        -e 'end tell'
      }
    end
  end
end
