require 'English'
require File.dirname(__FILE__) + '/escape'
require File.dirname(__FILE__) + '/osx/plist'

TM_DIALOG = e_sh ENV['DIALOG'] unless defined?(TM_DIALOG)

module TextMate

  module UI

    class << self
      # safest way to use Dialog
    	# see initialize for calling info
      def dialog(*args)
        d = Dialog.new(*args)
        begin
          yield d
        rescue StandardError => error
          puts 'Received exception:' + error
        ensure
          d.close
        end
      end

      # present an alert
    	def alert(style, title, message, *buttons)
    		styles = [:warning, :informational, :critical]
    		raise "style must be one of #{types.inspect}" unless styles.include?(style)
		
    		params = {'alertStyle' => style.to_s, 'messageTitle' => title, 'informativeText' => message, 'buttonTitles' => buttons}
        button_index = %x{#{TM_DIALOG} -ep #{e_sh params.to_plist}}.chomp.to_i
    		buttons[button_index]
    	end

      # show the system color picker and return a hex-format color (#RRGGBB).
      # If the input string is a recognizable hex string, the default color will be set to it.
      def request_color(string = nil)
        string = '#999' unless string.to_s.match(/#?[0-9A-F]{3,6}/i)
        color  = string
        prefix, string = string.match(/(#?)([0-9A-F]{3,6})/i)[1,2]
        string = $1 * 2 + $2 * 2 + $3 * 2 if string =~ /^(.)(.)(.)$/
        def_col = ' default color {' + string.scan(/../).map { |i| i.hex * 257 }.join(",") + '}'
        col = `osascript 2>/dev/null -e 'tell app "TextMate" to choose color#{def_col}'`
        return nil if col == "" # user cancelled -- when it happens, an exception is written to stderr
        col = col.scan(/\d+/).map { |i| "%02X" % (i.to_i / 257) }.join("")
    
        color = prefix
        if /(.)\1(.)\2(.)\3/.match(col) then
          color << $1 + $2 + $3
        else
          color << col
        end
        return color
      end
  
      # options should contain :title, :summary, and :log
      def simple_notification(options)
        raise if options.empty?

        support = ENV['TM_SUPPORT_PATH']
        nib     = support + '/nibs/SimpleNotificationWindow.nib'
    
        plist = Hash.new
        plist['title']    = options[:title]   || ''
        plist['summary']  = options[:summary] || ''
        plist['log']      = options[:log]     || ''

        `#{TM_DIALOG} -cqp #{e_sh plist.to_plist} #{e_sh nib} &> /dev/null &`
      end
  
      # pop up a menu on screen
      def menu(options)
        return nil if options.empty?

        return_hash = true
        if options[0].kind_of?(String)
          return_hash = false
          options = options.collect { |e| e == nil ? { 'separator' => 1 } : { 'title' => e } }
        end

        res = ::IO.popen("#{TM_DIALOG} -u", "r+") do |io|
          Thread.new do
            plist = { 'menuItems' => options }.to_plist
            io.write plist; io.close_write
          end
          OSX::PropertyList::load(io)
        end

        return nil unless res.has_key? 'selectedIndex'
        index = res['selectedIndex'].to_i

        return return_hash ? options[index] : index
      end

      # request a single, simple string
      def request_string(options = Hash.new,&block)
        request_string_core('Enter string:', 'RequestString', options, &block)
      end
      
      # request a password or other text which should be obscured from view
      def request_secure_string(options = Hash.new,&block)
        request_string_core('Enter password:', 'RequestSecureString', options, &block)
      end
      
      # show a standard open file dialog
      def request_file(options = Hash.new,&block)
        _options = default_options_for_cocoa_dialog(options)
        _options["title"] = options[:title] || "Select File"
        _options["informative-text"] = options[:prompt] || ""
        _options["text"] = options[:default] || ""
        _options["select-only-directories"] = "" if options[:only_directories]
        _options["with-directory"] = options[:directory] if options[:directory]
        cocoa_dialog("fileselect", _options,&block)
      end
      
      # show a standard open file dialog, allowing multiple selections 
      def request_files(options = Hash.new,&block)
        _options = default_options_for_cocoa_dialog(options)
        _options["title"] = options[:title] || "Select File(s)"
        _options["informative-text"] = options[:prompt] || ""
        _options["text"] = options[:default] || ""
        _options["select-only-directories"] = "" if options[:only_directories]
        _options["with-directory"] = options[:directory] if options[:directory]
        _options["select-multiple"] = ""
        cocoa_dialog("fileselect", _options,&block)
      end
            
      # Request an item from a list of items
      def request_item(options = Hash.new,&block)
        items = options[:items] || []
        case items.size
        when 0 then block_given? ? raise(SystemExit) : nil
        when 1 then block_given? ? yield(items[0]) : items[0]
        else
          params = default_buttons(options)
          params["title"] = options[:title] || "Select item:"
          params["prompt"] = options[:prompt] || ""
          params["string"] = options[:default] || ""
          params["items"] = items

          return_plist = %x{#{TM_DIALOG} -cmp #{e_sh params.to_plist} #{e_sh(ENV['TM_SUPPORT_PATH'] + "/nibs/RequestItem")}}
          return_hash = OSX::PropertyList::load(return_plist)

          # return string is in hash->result->returnArgument.
          # If cancel button was clicked, hash->result is nil.
          return_value = return_hash['result']
          return_value = return_value['returnArgument'] if not return_value.nil?
          return_value = return_value.first if return_value.is_a? Array

          if return_value == nil then
            block_given? ? raise(SystemExit) : nil
          else
            block_given? ? yield(return_value) : return_value
          end
        end
      end
      
      # Post a confirmation alert
      def request_confirmation(options = Hash.new,&block)
        button1 = options[:button1] || "Continue"
        button2 = options[:button2] || "Cancel"
        title   = options[:title]   || "Something Happened"
        prompt  = options[:prompt]  || "Should we continue or cancel?"

      	res = alert(:informational, title, prompt, button1, button2)

        if res == button1 then
          block_given? ? yield : true
        else
          block_given? ? raise(SystemExit) : false
        end
      end

        # Wrapper for tm_dialog. See the unit test in progress.rb
        class WindowNotFound < Exception
        end

        class Dialog    
          # instantiate an asynchronous nib
      		# two ways to call:
      		# Dialog.new(nib_path, parameters, defaults=nil)
      		# Dialog.new(:nib => path, :parameters => params, [:defaults => defaults], [:center => true/false])
          def initialize(*args)
      			nib_path, start_parameters, defaults, center = if args.size > 1
      				args
      			else
      				args = args[0]
      				[args[:nib], args[:parameters], args[:defaults], args[:center]]
      			end

            center_arg = center.nil? ? '' : '-c'
            defaults_args = defaults.nil? ? '' : %Q{-d #{e_sh defaults.to_plist}}

            command = %Q{#{TM_DIALOG} -a #{center_arg} #{defaults_args} #{e_sh nib_path}}
            @dialog_token = ::IO.popen(command, 'w+') do |io|
              io << start_parameters.to_plist
              io.close_write
              io.read.chomp
            end
            
            raise WindowNotFound, "No such dialog (#{@dialog_token})\n} for command: #{command}" if $CHILD_STATUS != 0
      #      raise "No such dialog (#{@dialog_token})\n} for command: #{command}" if $CHILD_STATUS != 0

            # this is a workaround for a presumed Leopard bug, see log entry for revision 8566 for more info
            if animate = start_parameters['progressAnimate']
              open("|#{TM_DIALOG} -t#{@dialog_token}", "w") { |io| io << { 'progressAnimate' => animate }.to_plist }
            end
          end

          # wait for the user to press a button (with performButtonClick: or returnArguments: action)
          # or the close box. Returns a dictionary containing the return argument values.
          # If a block is given, wait_for_input will pass the return arguments to the block
          # in a continuous loop. The block must return true to continue the loop, false to break out of it.
          def wait_for_input
            wait_for_input_core = lambda do
              text = %x{#{TM_DIALOG} -w #{@dialog_token} }
              raise WindowNotFound if $CHILD_STATUS == 54528  # -43
              raise "Error (#{text})" if $CHILD_STATUS != 0

              OSX::PropertyList::load(text)
            end

            if block_given? then
              loop do
                should_continue = yield(wait_for_input_core.call)
                break unless should_continue
              end
            else
              wait_for_input_core.call
            end
          end

          # update bindings with new value(s)
          def parameters=(parameters)
            text = ::IO.popen("#{TM_DIALOG} -t #{@dialog_token}", 'w+') do |io|
              io << parameters.to_plist
              io.close_write
              io.read
            end
            raise "Could not update (#{text})" if $CHILD_STATUS != 0
          end
          
          # close the window
          def close
            %x{#{TM_DIALOG} -x #{@dialog_token}}
          end

        end

      private
      
      # common to request_string, request_secure_string
      def request_string_core(default_prompt, nib_name, options, &block)
        params = default_buttons(options)
        params["title"] = options[:title] || default_prompt
        params["prompt"] = options[:prompt] || ""
        params["string"] = options[:default] || ""
        
        return_plist = %x{#{TM_DIALOG} -cmp #{e_sh params.to_plist} #{e_sh(ENV['TM_SUPPORT_PATH'] + "/nibs/#{nib_name}")}}
        return_hash = OSX::PropertyList::load(return_plist)
        
        # return string is in hash->result->returnArgument.
        # If cancel button was clicked, hash->result is nil.
        return_value = return_hash['result']
        return_value = return_value['returnArgument'] if not return_value.nil?
        
        if return_value == nil then
          block_given? ? raise(SystemExit) : nil
        else
          block_given? ? yield(return_value) : return_value
        end
      end

      def cocoa_dialog(type, options)
        str = ""
        options.each_pair do |key, value|
          unless value.nil?
            str << " --#{e_sh key} "
            str << Array(value).map { |s| e_sh s }.join(" ")
          end
        end
        cd = ENV['TM_SUPPORT_PATH'] + '/bin/CocoaDialog.app/Contents/MacOS/CocoaDialog'
        result = %x{#{e_sh cd} 2>/dev/console #{e_sh type} #{str} --float}
        result = result.to_a.map{|line| line.chomp}
        if (type == "fileselect")
          if result.length == 0
            return_value = options['button2'] # simulate cancel
          end
        else
          return_value, result = *result
        end
        if return_value == options["button2"] then
          block_given? ? raise(SystemExit) : nil
        else
          block_given? ? yield(result) : result
        end
      end
      
      def default_buttons(user_options = Hash.new)
        options = Hash.new
        options['button1'] = user_options[:button1] || "OK"
        options['button2'] = user_options[:button2] || "Cancel"
        options
      end
      
      def default_options_for_cocoa_dialog(user_options = Hash.new)
        options = default_buttons(user_options)
        options["string-output"] = ""
        options
      end
    end
  end
end

# interactive unit tests
if $0 == __FILE__
#  puts TextMate::UI.request_secure_string(:title => "Hotness", :prompt => 'Please enter some hotness', :default => 'teh hotness')

  puts TextMate::UI.request_item(:title => "Hotness", :prompt => 'Please enter some hotness', :items => ['hotness', 'coolness', 'iceness'])

  # params = {'title' => "Hotness", 'prompt' => 'Please enter some hotness', 'string' => 'teh hotness'}
  # return_value = %x{#{TM_DIALOG} -cmp #{e_sh params.to_plist} #{e_sh(ENV['TM_SUPPORT_PATH'] + '/nibs/RequestString')}}
  # return_hash = OSX::PropertyList::load(return_value)
  # puts return_hash['result'].inspect
  
#  puts TextMate::UI.dialog(:nib => , :parameters => , :center => true)
  
#	result = TextMate::UI.alert(:warning, 'The wallaby has escaped.', 'The hard disk may be full, or maybe you should try using a larger cage.', 'Dagnabit', 'I Am Relieved', 'Heavens')
	
#	puts "Button pressed: #{result}"
end

