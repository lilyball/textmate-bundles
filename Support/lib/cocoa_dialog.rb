module TextMate
  module_function

  def standard_input_box(title, prompt)
    _standard_input_box('standard-inputbox', title, prompt)
  end

  def secure_standard_input_box(title, prompt)
    _standard_input_box('secure-standard-inputbox', title, prompt)
  end

  def input_box(title, prompt, text = "", button1 = "Okay", button2 = "Cancel")
    _standard_input_box('inputbox', title, prompt, text, button1, button2)
  end

  def dropdown(options)
    _dialog('dropdown', options)
  end

  private

  def _dialog(options)
    type = options[:type]
    string = ""
    options.each_pair do |key, value|
      string << " --#{key}"
      Array(value).each do |i|
          i.
        end
    end
    %x{"#{ENV['TM_SUPPORT_PATH']}/bin/CocoaDialog.app/Contents/MacOS/CocoaDialog" 2>/dev/console #{type} #{options}}
  end

  def _standard_input_box(type, title, prompt, text, button1 = "Okay", button2 = "Cancel")
    require "#{ENV['TM_SUPPORT_PATH']}/lib/escape.rb"
    _result = _dialog(type, %Q{--title #{e_sh title} \
      --informative-text #{e_sh prompt} --text #{e_sh text} \
      --button1 #{e_sh button1} --button2 #{e_sh button2}})
    _result = _result.split(/\n/)
    _result[0] == '1' ? _result[1] : nil
  end
end
