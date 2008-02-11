require "#{ENV['TM_BUNDLE_SUPPORT']}/lib/keychain"
require "#{ENV['TM_SUPPORT_PATH']}/lib/escape"
require "#{ENV['TM_SUPPORT_PATH']}/lib/osx/plist"
require "#{ENV['TM_SUPPORT_PATH']}/lib/exit_codes"
require "#{ENV['TM_SUPPORT_PATH']}/lib/web_preview"

BUNDLE_SUPPORT = ENV['TM_BUNDLE_SUPPORT']

TM_DIALOG = e_sh ENV['DIALOG'] unless defined?(TM_DIALOG)

#ApacheCTL - Apache HTTP Server Control Interface (ruby proxy)
class ApacheCTL

    KEYCHAIN_ACCOUNT = "TextMate Bundle"
    KEYCHAIN_SERVICE = "Apache.tmbundle"
    SUDO_FAIL_MESSAGE = /Sorry, try again\.\n/

    private

    def initialize
        at_exit { finalize() }
    end

    def finalize
        # If the user password was gathered during this process, and
        # was successfully used, save it for the next command request.
        finally_save_password() if @save_password_on_success
    end

    def finally_save_password
        KeyChain.add_generic_password( KEYCHAIN_ACCOUNT, KEYCHAIN_SERVICE, self.password )
    end

    def fetch_password_from_keychain
        if @password == nil
            @password = KeyChain.find_generic_password(KEYCHAIN_ACCOUNT, KEYCHAIN_SERVICE)
            if @password == nil

                return_hash = request_apache_password()
                #return string is in hash->result->returnArgument.
                #If cancel button was clicked, hash->result is nil.
                @password = return_hash['result']
                @password = @password['returnArgument'] if not @password.nil?

                TextMate.exit_discard if @password == nil
                @save_password_on_success = true if not return_hash['addToKeychain'].nil?
                
            else
                @keychain_password = true
            end
        end
    end
    
    def ctl_proxy(cmd, msg='Ok')

      require_cmd('apachectl')

      result = `echo "#{self.password}" | sudo -S apachectl #{cmd} 2>&1; sudo -k`.sub("Password:\n","")
      result = msg if result.empty?

      if result =~ SUDO_FAIL_MESSAGE
          @save_password_on_success = false;
          if @keychain_password == true
              puts html_head(:window_title => "Apache Bundle", :page_title => "Keychain Password Error.", :sub_title => "__" );
              puts '<p>Your stored keychain password failed.</p>'
              puts '<p>Please use the Kechain Access application to edit or delete your Apache.tmbundle keychain item then run this command again.</p>'
              TextMate.exit_show_html()            
          end
          result = "Password failed."
      end

      TextMate.exit_show_tool_tip(result)

    end
    
    def require_cmd(cmd)
        exists = ENV['PATH'].split(':').any? { |dir| 
            File.executable? File.join(dir, cmd)
        }
        unless exists
            puts html_head(:window_title => "Apache Bundle", :page_title => "apachectl", :sub_title => "404" );
            puts '<h3 class="error">Couldn\'t find ‘' + cmd + '’</h3><p>Locations searched:</p><p><pre>'
            puts ENV['PATH'].gsub(/:/, "\n") + '</pre></p>'
            TextMate.exit_show_html()
        end    
    end
    
    def request_apache_password()

        params = Hash.new
        params[ "button1" ] = "OK"
        params[ "button2" ] = "Cancel"
        params[ "title"   ] = "Apache Admistration Password Request"
        params[ "prompt"  ] = "Enter password:"
        params[ "string"  ] = ""
        params[ "addToKeychain"  ] = "0"
      
        return_plist = %x{#{TM_DIALOG} -cmp #{e_sh params.to_plist} #{e_sh(BUNDLE_SUPPORT+"/nibs/RequestSecureStringKeychain.nib")}}
        return_hash = OSX::PropertyList::load(return_plist)
        
    end

    public

    # Getters/Setters

    def password
        fetch_password_from_keychain() unless @password
        @password
    end

    # Commands

    def graceful
        ctl_proxy('graceful','httpd gracefully restarted')
    end

    def restart
        ctl_proxy('restart','httpd restarted')
    end

    def start
        ctl_proxy('start','httpd started')
    end

    def stop
        ctl_proxy('stop','httpd stopped')
    end

end