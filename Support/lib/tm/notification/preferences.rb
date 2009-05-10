require ENV['TM_SUPPORT_PATH'] + '/lib/ui'
require ENV['TM_SUPPORT_PATH'] + '/lib/tm/notification'
require ENV['TM_SUPPORT_PATH'] + '/lib/tm/notification/configuration'

module TextMate
  module Notification
    module Preferences
       class  << self

         @@filename = File.expand_path "~/Library/Preferences/com.macromates.textmate.notifications.plist"
         @@prefs = nil

         def read
           if File.exists? @@filename
             File.open(@@filename, "r") do |f|
               @@prefs = OSX::PropertyList.load(f)
             end
           else
             @@prefs = {
               "notifications" => []
             }
           end
         end

         def save
           File.open(@@filename, "w+") do |f|
             f << @@prefs.to_plist
           end
         end

         def configurations
           @@prefs["notifications"].collect { |c| Configuration.new(c) }
         end

         def show
           TextMate::UI.dialog(
             :nib => ENV['TM_SUPPORT_PATH'] + '/lib/tm/notification/NotificationPreferences.nib', 
             :parameters => {
               "preferences" => @@prefs,
               "types" => Notification.types.collect { |t| {"name" => t.name, "code" => t.code} }
             }
           ) do |dialog|
             dialog.wait_for_input do |params|
               @@prefs = params["preferences"]
               puts @@prefs.inspect
               save
               false
             end
           end 
         end

         Preferences.read

       end
     end
  end
end