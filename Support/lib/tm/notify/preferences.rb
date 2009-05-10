require ENV['TM_SUPPORT_PATH'] + '/lib/ui'
require ENV['TM_SUPPORT_PATH'] + '/lib/tm/notify/mechanism/tooltip'
require ENV['TM_SUPPORT_PATH'] + '/lib/tm/notify/notification'

module TextMate
  module Notify
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
               "notifications" => [
                 {"name" => "All", "mechanism" => Mechanism::Tooltip.notification_pref_hash, "scope_selector" => ""}
                ]
             }
           end
         end

         def save
           File.open(@@filename, "w+") do |f|
             f << @@prefs.to_plist
           end
         end

         def notifications
           @@prefs["notifications"].collect { |c| Notification.new(c) }
         end

         def show
           TextMate::UI.dialog(
             :nib => ENV['TM_SUPPORT_PATH'] + '/lib/tm/notify/NotificationPreferences.nib', 
             :parameters => {
               "preferences" => @@prefs,
               "mechanisms" => Mechanism.all.collect { |m| m.notification_pref_hash }
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