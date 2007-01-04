require 'English'
require File.dirname(__FILE__) + '/escape'
require File.dirname(__FILE__) + '/plist'

module TextMate
  # Wrapper for tm_dialog. See the unit test in progress.rb
  class WindowNotFound < Exception
  end

  class Dialog
    TM_SUPPORT    = File.expand_path(File.dirname(__FILE__) + '/..')
    TM_DIALOG     = TM_SUPPORT + '/bin/tm_dialog'

		def self.alert(style, title, message, *buttons)
			styles = [:warning, :informational, :critical]
			raise "style must be one of #{types.inspect}" unless styles.include?(style)
			
			params = {'alertStyle' => style.to_s, 'messageTitle' => title, 'informativeText' => message, 'buttonTitles' => buttons}
	    button_index = %x{#{e_sh TM_DIALOG} -ep #{e_sh params.to_plist}}.chomp.to_i
			buttons[button_index]
		end

    # safest way to use this object
    def self.dialog(nib_path, parameters, defaults= nil)
      dialog = Dialog.new(nib_path, parameters, defaults)
      begin
        yield dialog
      rescue StandardError => error
        puts 'Received exception:' + error
      ensure
        dialog.close
      end
    end
    
    # instantiate an asynchronous nib
    def initialize(nib_path, start_parameters, defaults = nil)
      defaults_args = ''
      defaults_args = %Q{-d #{e_sh defaults.to_plist}} unless defaults.nil?
      
      command = %Q{#{e_sh TM_DIALOG} -a -p #{e_sh start_parameters.to_plist} #{defaults_args} #{e_sh nib_path}}
      @dialog_token = %x{#{command}}.chomp
      raise WindowNotFound, "No such dialog (#{@dialog_token})\n} for command: #{command}" if $CHILD_STATUS != 0
#      raise "No such dialog (#{@dialog_token})\n} for command: #{command}" if $CHILD_STATUS != 0
    end

    # wait for the user to press a button (with performButtonClick: or returnArguments: action)
    # or the close box. Returns a dictionary containing the return argument values.
    # If a block is given, wait_for_input will pass the return arguments to the block
    # in a continuous loop. The block must return true to continue the loop, false to break out of it.
    def wait_for_input
      wait_for_input_core = lambda do
        text = %x{#{e_sh TM_DIALOG} -w #{@dialog_token} }
        raise WindowNotFound if $CHILD_STATUS == 54528  # -43
        raise "Error (#{text})" if $CHILD_STATUS != 0

        PropertyList::load(text)
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
      text = %x{#{e_sh TM_DIALOG} -t #{@dialog_token} -p #{e_sh parameters.to_plist}}
      raise "Could not update (#{text})" if $CHILD_STATUS != 0
    end
    
    # close the window
    def close
      %x{#{e_sh TM_DIALOG} -x #{@dialog_token}}
    end
    
  end
end

module Dialog
class << self
  def request_color(string)
    string = '#999' unless string.match(/#?[0-9A-F]{3,6}/i)
    color  = string
    prefix, string = string.match(/(#?)([0-9A-F]{3,6})/)[1,2]
    string = $1 * 2 + $2 * 2 + $3 * 2 if string =~ /^(.)(.)(.)$/
    def_col = ' default color {' + string.scan(/../).map { |i| i.hex * 257 }.join(",") + '}'
    col = `osascript 2>/dev/null -e 'tell app "TextMate" to choose color#{def_col}'`
    return color if col == ""
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
    dialog  = support + '/bin/tm_dialog'
    nib     = support + '/nibs/SimpleNotificationWindow.nib'
    
    plist = Hash.new
    plist['title']    = options[:title]   || ''
    plist['summary']  = options[:summary] || ''
    plist['log']      = options[:log]     || ''

    `#{e_sh dialog} -cap #{e_sh plist.to_plist} #{e_sh nib} &> /dev/null &`
  end
  
  def menu(options)
    return nil if options.empty?

    support = ENV['TM_SUPPORT_PATH']
    dialog = support + '/bin/tm_dialog'

    return_hash = true
    if options[0].kind_of?(String)
      return_hash = false
      options = options.collect { |e| e == nil ? { 'separator' => 1 } : { 'title' => e } }
    end

    plist = { 'menuItems' => options }.to_plist
    
    res = PropertyList::load(`#{e_sh dialog} -up #{e_sh plist}`)
    return nil unless res.has_key? 'selectedIndex'
    index = res['selectedIndex'].to_i

    return return_hash ? options[index] : index
  end
  def request_string(options = Hash.new,&block)
    _options = default_hash(options)
    _options["title"] = options[:title] || "Enter String"
    _options["informative-text"] = options[:prompt] || ""
    _options["text"] = options[:default] || ""
    dialog("inputbox", _options,&block)
  end
  def request_file(options = Hash.new,&block)
    _options = default_hash(options)
    _options["title"] = options[:title] || "Select File"
    _options["informative-text"] = options[:prompt] || ""
    _options["text"] = options[:default] || ""
    dialog("fileselect", _options,&block)
  end
  def request_files(options = Hash.new,&block)
    _options = default_hash(options)
    _options["title"] = options[:title] || "Select File(s)"
    _options["informative-text"] = options[:prompt] || ""
    _options["text"] = options[:default] || ""
    _options["select-multiple"] = ""
    dialog("fileselect", _options,&block)
  end
  def request_secure_string(options = Hash.new,&block)
    _options = default_hash(options)
    _options["title"] = options[:title] || "Enter Password"
    _options["informative-text"] = options[:prompt] || ""
    _options["text"] = options[:default] || ""
    dialog("secure-inputbox", _options,&block)
  end
  def request_item(options = Hash.new,&block)
    items = options[:items] || []
    case items.size
    when 0 then block_given? ? raise(SystemExit) : nil
    when 1 then block_given? ? yield(items[0]) : items[0]
    else
      _options = default_hash(options)
      _options["title"] = options[:title] || "Select Item"
      _options["text"] = options[:prompt] || ""
      _options["items"] = items
      dialog("dropdown", _options,&block)
    end
  end
  def request_confirmation(options = Hash.new,&block)
    button1 = options[:button1] || "Continue"
    button2 = options[:button2] || "Cancel"
    title   = options[:title]   || "Something Happened"
    prompt  = options[:prompt]  || "Should we continue or cancel?"

    res = %x{ iconv <<'APPLESCRIPT' -f utf-8 -t mac|osascript 2>/dev/null
      prop the_buttons : {"#{e_as button2}", "#{e_as button1}"}
      tell app "TextMate"
        display alert "#{e_as title}" message "#{e_as prompt}" as informational ¬
        buttons the_buttons default button 2 cancel button 1
        set the_button to button returned of result
        if the_button is equal to item 2 of the_buttons then return true
      end tell
    }

    if res =~ /true/ then
      block_given? ? yield : true
    else
      block_given? ? raise(SystemExit) : false
    end
  end
  # def show_alert(options = Hash.new,&block)
  #   _options = Hash.new
  #   _options["string-output"] = ""
  #   _options["title"] = options[:title] || "Alert"
  #   _options["text"] = options[:prompt] || "Is this Ok?"
  #   _options["informative-text"] = options[:information]
  #   _options["icon-file"] = textmate_path + '/Contents/Resources/TextMate.icns'
  #   dialog("ok-msgbox", _options,&block)
  # end

  private

  # def textmate_path
  #   require "textmate"
  #   TextMate.app_path
  # end
  def dialog(type, options)
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
  def default_hash(user_options = Hash.new)
    options = Hash.new
    options["string-output"] = ""
    options["button1"] = user_options[:button1] || "Okay"
    options["button2"] = user_options[:button2] || "Cancel"
    options
  end
end
end

# interactive unit tests
if $0 == __FILE__
	result = TextMate::Dialog.alert(:warning, 'The wallaby has escaped.', 'The hard disk may be full, or maybe you should try using a larger cage.', 'Dagnabit', 'I Am Relieved', 'Heavens')
	
	puts "Button pressed: #{result}"
end

