require "#{ENV['TM_SUPPORT_PATH']}/lib/escape.rb"
require "#{ENV['TM_BUNDLE_SUPPORT']}/lib/keychain.rb"
require "#{ENV['TM_BUNDLE_SUPPORT']}/lib/textmate.rb"

#ApacheCTL - Apache HTTP Server Control Interface
class ApacheCTL
    
    KEYCHAIN_ACCOUNT = "TextMate Bundle"
    KEYCHAIN_SERVICE = "Apache.tmbundle"
        
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
                
                return_hash = TextMate.request_apache_password()
                
                #return string is in hash->result->returnArgument.
                #If cancel button was clicked, hash->result is nil.
                @password = return_hash['result']
                @password = @password['returnArgument'] if not @password.nil?
                
                TextMate.exit_discard if @password == nil
                @save_password_on_success = true if not return_hash['addToKeychain'].nil?                
            end
        end
    end

    public

    # Getters/Setters

    def password
        fetch_password_from_keychain() unless @password
        @password
    end

    # Commands

    def graceful
        result = `echo "#{self.password}" | sudo -S apachectl graceful 2>&1; sudo -k`.sub("Password:\n","")
        result = "httpd restarted" if result.empty?
        TextMate.exit_show_tool_tip(result)
    end

    def restart
        result = `echo "#{self.password}" | sudo -S apachectl restart 2>&1; sudo -k`.sub("Password:\n","")
        result = "httpd restarted" if result.empty?
        TextMate.exit_show_tool_tip(result)        
    end

    def start
        result = `echo "#{self.password}" | sudo -S apachectl start 2>&1; sudo -k`.sub("Password:\n","")
        result = "httpd started" if result.empty?
        
        #Return value when httpd has already been stopped.
        #org.apache.httpd: Already loaded
        
        TextMate.exit_show_tool_tip(result)        
    end

    def stop
        result = `echo "#{self.password}" | sudo -S apachectl stop 2>&1; sudo -k`.sub("Password:\n","")
        result = "httpd stopped" if result.empty?
        
        #Return value when httpd has already been stopped.
        #launchctl: Error unloading: org.apache.httpd
        
        TextMate.exit_show_tool_tip(result)
    end
    
    def test

        result = `echo "#{self.password}" | sudo -S apachectl stop 2>&1; sudo -k`.sub("Password:\n","")
        result = "httpd stopped" if result.empty?        
        
        #Match for a failed sudo...
        if result =~ /Sorry, try again\.\n/
            #TODO: Start again and retry password.
            @save_password_on_success = false;
        end
        
        TextMate.exit_show_html(result)
        
    end

end