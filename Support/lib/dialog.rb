require "escape.rb"
module Dialog
  module_function

  def request_string(options = Hash.new,&block)
    _options = self.default_hash
    _options["type"] = "inputbox"
    _options["title"] = options[:title] || "Enter String"
    _options["informative-text"] = options[:prompt] || ""
    _options["text"] = options[:default] || ""
    return self.dialog(_options,&block)
  end
  def request_secure_string(options = Hash.new,&block)
    _options = self.default_hash
    _options["type"] = "secure-inputbox"
    _options["title"] = options[:title] || "Enter Password"
    _options["informative-text"] = options[:prompt] || ""
    _options["text"] = options[:default] || ""
    return self.dialog(_options,&block)
  end
  def drop_down(options = Hash.new,&block)
    items = options[:items] || []
    if items.empty? then
      block_given? raise SystemExit : return nil
    elsif items.length == 1 then
      block_given? yield items[0] : return items[0]
    else
      _options = self.default_hash
      _options["type"] = "dropdown"
      _options["title"] = options[:title] || "Select Item"
      _options["text"] = options[:prompt] || ""
      return self.dialog(_options,&block)
    end
  end

  private

  def dialog(options)
    type = options.delete("type")
    str = ""
    options.each_pair do |key, value|
      str << " --#{e_sh key} "
      str << Array(value).map { |s| e_sh s }.join(" ")
    end
    cd = ENV['TM_SUPPORT_PATH'] + '/bin/CocoaDialog.app/Contents/MacOS/CocoaDialog'
    result = %x{#{e_sh cd} 2>/dev/console #{e_sh type} #{str} --float}
    return_value, result = result.to_a.map{|line| line.chomp}
    if return_value == "Cancel" then
      if block_given? then
        raise SystemExit
      else
        return nil
      end
    else
      block_given? ? yield result : result
    end
  end
  def default_hash
    return {
      "string-output" => "",
      "button1" => "Ok",
      "button2" => "Cancel"
    }
  end
end
