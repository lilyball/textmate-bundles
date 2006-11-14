require File.join(File.dirname(__FILE__),'escape.rb')
module Dialog
class << self
  def request_color(string)
    string = '#999' unless string
    color  = ''
    prefix, string = string.match(/(#?)(.*)/)[1,2]
    string = $1 * 2 + $2 * 2 + $3 * 2 if string =~ /^(.)(.)(.)$/
    def_col = ' default color {' + string.scan(/../).map { |i| i.hex * 257 }.join(",") + '}'
    col = `osascript 2>/dev/null -e 'tell app "TextMate" to choose color#{def_col}'`
    return false if col == ""
    col = col.scan(/\d+/).map { |i| "%02X" % (i.to_i / 257) }.join("")
    
    color = prefix
    if /(.)\1(.)\2(.)\3/.match(col) then
      color << $1 + $2 + $3
    else
      color << col
    end
    color
  end
  def menu(options)
    return nil if options.empty?

    support = ENV['TM_SUPPORT_PATH']
    dialog = support + '/bin/tm_dialog'
    require support + '/lib/plist'

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
