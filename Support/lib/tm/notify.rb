require ENV['TM_SUPPORT_PATH'] + '/lib/tm/process'
require ENV['TM_SUPPORT_PATH'] + '/lib/growl'
require ENV['TM_SUPPORT_PATH'] + '/lib/textmate'
require ENV['TM_SUPPORT_PATH'] + '/lib/ui'
require ENV['TM_SUPPORT_PATH'] + '/lib/escape'
require ENV['TM_SUPPORT_PATH'] + '/lib/osx/plist'

module TextMate
  
  class << self
    def notify(id, title, msg)
        Notification.new(id, title, msg).notify
    end
  end
  
  class Notification

    attr_reader :id, :title, :msg, :pref
    
    def initialize(id, title, msg)
      @id = id
      @title = title
      @msg = msg
      @pref = Preferences[id] # ensures that we are in the preferences (needed for Preferences.notification_ids)
    end
    
    def growl_available?
      %x{ps -xwwco "command" | grep -sq '^GrowlHelperApp$'}
      $? == 0
    end
    
    def prefers_growl?
      @pref["growl"] == true
    end

    def should_growl?
      prefers_growl? and growl_available?
    end
    
    def notify
      should_growl? ? growl : tooltip
    end
            
    def growl
      n_ids = Preferences.notification_ids
      growl = GrowlNotifier.new("TextMate", n_ids, n_ids, icon)
      growl.register
      growl.notify(id, title, msg)
    end

    def tooltip
      TextMate::UI.tool_tip("<strong>#{htmlize title}</strong><p>#{htmlize msg}</p>", :format => :html)
    end
    
    def icon
      require 'osx/cocoa'
      OSX::NSImage.alloc().initWithContentsOfFile_(TextMate.app_path + "/Contents/Resources/TextMate.icns")
    end
    
    module Preferences
      class  << self
        
        @@notifications_key = "notifications"
        @@global_key = "global"
        
        @@filename = File.expand_path "~/Library/Preferences/com.macromates.textmate.notifications.plist"
        
        @@prefs = nil
        
        def read
          if File.exists? @@filename
            File.open(@@filename, "r") do |f|
              @@prefs = OSX::PropertyList.load(f)
            end
          else
            @@prefs = {
              @@global_key => {
                "growl" => true
              },
              @@notifications_key => {}
            }
          end
        end
        
        def save
          File.open(@@filename, "w+") do |f|
            f << @@prefs.to_plist
          end
        end
        
        def [](key) 
          n = @@prefs[@@notifications_key][key]
          if n.nil?
            n = {}
            @@prefs[@@notifications_key][key] = n
            save
          end
          @@prefs[@@global_key].merge n
        end

        def notification_ids 
          @@prefs[@@notifications_key].keys
        end
        
        Preferences.read
      end
    end
  end
end
