# Example usage:
# 
#   require "password"
# 
#   TextMate.call_with_password({ :user => 'duff', :url => 'http://example.com/blog/xmlrpc.php' }) do |pw|
#     pw == "foo" ? :reject_pw : :accept_pw
#   end

module TextMate

  def TextMate.call_with_password(args, &block)
    user, url = args[:user], args[:url]
    abort "misformed URL #{url}" unless url =~ %r{^(\w+)://([^/]+)(.*?/?)[^/]*$}
    proto, host, path = $1, $2, $3

    action = :reject_pw

    res = %x{security find-internet-password -g -a "#{user}" -s "#{host}" -p "#{path}" -r #{proto} 2>&1 >/dev/null}
    action = block.call($1) if res =~ /^password: "(.*)"$/
    
    while action == :reject_pw
      cd_path = ENV['TM_SUPPORT_PATH'] + '/bin/CocoaDialog.app/Contents/MacOS/CocoaDialog'
      res = %x{"#{cd_path}" secure-standard-inputbox \
        --title "Enter Password" \
        --informative-text "Enter password for #{user} at #{proto}://#{host}#{path}"
      }
      break if res[0] == ?2

      action = block.call(res[2..-2])
      if action == :accept_pw then
        %x{security add-internet-password -a "#{user}" -s "#{host}" -r "#{proto}" -p "#{path}" -w "#{res[2..-2]}"}
      end
    end

    return action
  end

end
