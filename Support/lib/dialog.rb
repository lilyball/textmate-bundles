require "escape.rb"
module CocaDialog
  module_function

  def request_string(hash = Hash.new,&block)
    options = self.default_hash
    options["type"] = "inputbox"
    options["title"] = hash[:title] || "Enter String"
    options["informative-text"] = hash[:prompt] || ""
    options["text"] = hash[:default] || ""
    return self.dialog(options,&block)
  end
  def request_secure_string(hash = Hash.new,&block)
    options = self.default_hash
    options["type"] = "secure-inputbox"
    options["title"] = hash[:title] || "Enter Password"
    options["informative-text"] = hash[:prompt] || ""
    options["text"] = hash[:default] || ""
    return self.dialog(options,&block)
  end
  def drop_down(hash = Hash.new,&block)
    items = hash[:items] || []
    if items.empty? then
      block_given? raise SystemExit : return nil
    elsif items.length == 1 then
      block_given? yield items[0] : return items[0]
    else
      options = self.default_hash
      options["type"] = "dropdown"
      options["title"] = hash[:title] || "Select Item"
      options["text"] = hash[:prompt] || ""
      return self.dialog(options,&block)
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
