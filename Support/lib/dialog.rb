module CocaDialog
  require "escape.rb"
  module_function

  def request_string(hash = Hash.new,&block)
    options["type"] = "inputbox"
    options["title"] = hash[:title] || "Enter String"
    options["informative-text"] = hash[:prompt] || ""
    options["text"] = hash[:default] || ""
    options["button1"] = "Ok"
    options["button2"] = "Cancel"
    return self.dialog(options,&block)
  end
  def request_secure_string(hash = Hash.new,&block)
    options["type"] = "secure-inputbox"
    options["title"] = hash[:title] || "Enter Password"
    options["informative-text"] = hash[:prompt] || ""
    options["text"] = hash[:default] || ""
    options["button1"] = "Ok"
    options["button2"] = "Cancel"
    return self.dialog(options,&block)
  end
  def drop_down(hash = Hash.new,&block)
    # FIX _dialog('dropdown', options)
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
    result = %x{#{e_sh cd} 2>/dev/console #{e_sh type} #{str}}
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
end
