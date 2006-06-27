require "escape.rb"
module Dialog
class << self
  def request_string(options = Hash.new,&block)
    _options = default_hash(options)
    _options["title"] = options[:title] || "Enter String"
    _options["informative-text"] = options[:prompt] || ""
    _options["text"] = options[:default] || ""
    dialog("inputbox", _options,&block)
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
    _options = Hash.new
    _options["string-output"] = ""
    _options["title"] = options[:title] || "Yes or No?"
    _options["text"] =  options[:prompt] || "Please answer Yes or No."
    _options["informative-text"] = options[:information]
    dialog("yesno-msgbox", _options,&block)    
  end
  def show_alert(options = Hash.new,&block)
    _options = Hash.new
    _options["string-output"] = ""
    _options["title"] = options[:title] || "Alert"
    _options["text"] = options[:prompt] || "Is this Ok?"
    _options["informative-text"] = options[:information]
    _options["icon-file"] = textmate_path + '/Contents/Resources/TextMate.icns'
    dialog("ok-msgbox", _options,&block)
  end

  private

  def textmate_path
    %x{ps -xww -o command|grep TextMate.app|grep -v grep}.sub(%r{/Contents/MacOS/TextMate.*\n}, '')
  end
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
    return_value, result = result.to_a.map{|line| line.chomp}
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
