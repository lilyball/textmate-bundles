#!/usr/bin/env ruby
require "#{ENV['TM_SUPPORT_PATH']}/lib/textmate"
# 
# if %x{ defaults read /System/Library/CoreServices/SystemVersion ProductVersion } =~ /\A10\.4/
#   %x{"#{ENV['TM_BUNDLE_SUPPORT']}/bin/converter.sh"}
#   USE_MAC = 'mac/'
# else 
   USE_MAC = ''
# end

GROWL_TEST        = ENV['TM_BUNDLE_SUPPORT'] + "/as/" + USE_MAC + "growl_test.scpt"
REGISTER          = ENV['TM_BUNDLE_SUPPORT'] + "/as/" + USE_MAC + "register.scpt"
NOTIFY_INSTALLED  = ENV['TM_BUNDLE_SUPPORT'] + "/as/" + USE_MAC + "installed.scpt"
NOTIFY_UPDATED    = ENV['TM_BUNDLE_SUPPORT'] + "/as/" + USE_MAC + "updated.scpt"
NOTIFY_FAILED     = ENV['TM_BUNDLE_SUPPORT'] + "/as/" + USE_MAC + "update_failed.scpt"

growl = %x{osascript "#{GROWL_TEST}"}

if growl = "true"
  
  %x{osascript "#{REGISTER}"}
  case ARGV[0]
    when 'installed'
      %x{osascript "#{NOTIFY_INSTALLED}" #{ARGV[1]}}
    when 'updated'
      %x{osascript "#{NOTIFY_UPDATED}"}
    when 'update_failed'
      %x{osascript "#{NOTIFY_FAILED}"}
  end  

else

  case ARGV[0]
    when 'installed'
      %x{CocoaDialog bubble --title "Installed Bundle: #{ARGV[1]}" --text 'You now can use the new Bundle' --icon-file "#{TextMate.app_path}/Contents/Resources/Textmate.icns"}
    when 'updated'
      %x{CocoaDialog bubble --title 'All Bundles Updated' --text 'You can use them now' --icon-file "#{TextMate.app_path}/Contents/Resources/Textmate.icns"}
    when 'update_failed'
      %x{CocoaDialog bubble --title 'Could not update your Bundles' --text 'Use \"Check your Internet Connection\".' --icon-file "#{TextMate.app_path}/Contents/Resources/Textmate.icns"}
  end

end
