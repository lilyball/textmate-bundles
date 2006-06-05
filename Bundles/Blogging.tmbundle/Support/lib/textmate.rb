module TextMate
  class << self

    public

    def exit_discard
      exit 200
    end

    def exit_replace_text(out = nil)
      print out if out
      exit 201
    end

    def exit_replace_document(out = nil)
      print out if out
      exit 202
    end

    def exit_insert_text(out = nil)
      print out if out
      exit 203
    end

    def exit_insert_snippet(out = nil)
      print out if out
      exit 204
    end

    def exit_show_html(out = nil)
      print out if out
      exit 205
    end

    def exit_show_tool_tip(out = nil)
      print out if out
      exit 206
    end

    def exit_create_new_document(out = nil)
      print out if out
      exit 207
    end

    def standard_input_box(title, prompt)
      _standard_input_box('standard-inputbox', title, prompt)
    end

    def secure_standard_input_box(title, prompt)
      _standard_input_box('secure-standard-inputbox', title, prompt)
    end

    def inputbox(options)
      _dialog('inputbox', options)
    end

    def dropdown(options)
      _dialog('dropdown', options)
    end

    private

    def _dialog(type, options)
      %x{"#{ENV['TM_SUPPORT_PATH']}/bin/CocoaDialog.app/Contents/MacOS/CocoaDialog" #{type} #{options}}
    end

    def _standard_input_box(type, title, prompt)
      _result = _dialog(type, %Q{--title "#{title.gsub(/"/, "\\\"")}" \
        --informative-text "#{prompt.gsub(/"/, "\\\"")}"})
      _result = _result.split(/\n/)
      _result[0] == '1' ? _result[1] : nil
    end
  end
end