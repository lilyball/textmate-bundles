require ENV['TM_SUPPORT_PATH']  + '/lib/escape'
require ENV['TM_SUPPORT_PATH']  + '/lib/osx/plist'

BUNDLE_SUPPORT = ENV['TM_BUNDLE_SUPPORT']

TM_DIALOG = e_sh ENV['DIALOG'] unless defined?(TM_DIALOG)

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

    def input_box(title, prompt, text = "", button1 = "Okay", button2 = "Cancel")
      _standard_input_box('inputbox', title, prompt, text, button1, button2)
    end

    def dropdown(options)
      _dialog('dropdown', options)
    end
        
    def request_apache_password()

        params = Hash.new
        params[ "button1" ] = "OK"
        params[ "button2" ] = "Cancel"
        params[ "title"   ] = "Apache Admistration Password Request"
        params[ "prompt"  ] = "Enter password:"
        params[ "string"  ] = ""
      
        return_plist = %x{#{TM_DIALOG} -cmp #{e_sh params.to_plist} #{e_sh(BUNDLE_SUPPORT+"/nibs/RequestSecureStringKeychain.nib")}}
        return_hash = OSX::PropertyList::load(return_plist)
        
    end
    
    private

    def _dialog(type, options)
      %x{"#{ENV['TM_SUPPORT_PATH']}/bin/CocoaDialog.app/Contents/MacOS/CocoaDialog" 2>/dev/console #{type} --float #{options}}
    end

    def _standard_input_box(type, title, prompt, text = "", button1 = "Okay", button2 = "Cancel")
      require "#{ENV['TM_SUPPORT_PATH']}/lib/escape.rb"
      _result = _dialog(type, %Q{--title #{e_sh title} --informative-text #{e_sh prompt}#{text.length > 0 ? " --text " + e_sh(text) : ""} --button1 #{e_sh button1} --button2 #{e_sh button2}})
      _result = _result.split(/\n/)
      _result[0] == '1' ? _result[1] : nil
    end    
    
  end
end