require ENV['TM_SUPPORT_PATH'] + '/lib/tm/process'
require ENV['TM_SUPPORT_PATH'] + '/lib/growl'
require ENV['TM_SUPPORT_PATH'] + '/lib/textmate'
require ENV['TM_SUPPORT_PATH'] + '/lib/ui'
require ENV['TM_SUPPORT_PATH'] + '/lib/escape'
require "pstore"

module TextMate
  class << self
    def notify(id, title, msg)
      if Notification.growl_available?
        Notification.growl_notify(id, title, msg)
      else
        Notification.tooltip_notify(id, title, msg)
      end
    end
  end
  
  module Notification
    class << self

      @@prefs = PStore.new(File.expand_path( "~/Library/Preferences/com.macromates.textmate.notifications"))

      def get_pref(key) 
        @@prefs.transaction { @@prefs[key] }
      end

      def set_pref(key, value) 
        @@prefs.transaction { @@prefs[key] = value }
      end
      
      def growl_available?
        %x{ps -xwwco "command" | grep -sq '^GrowlHelperApp$'}
        $? == 0
      end
      
      def growl_notify(id, title, msg)
        record_id(id)
        n_ids = notification_ids
        growl = GrowlNotifier.new("TextMate", n_ids, n_ids, tm_icon)
        growl.register
        growl.notify(id, title, msg)
      end

      def tooltip_notify(id, title, msg)
        record_id(id)
        TextMate::UI.tool_tip("<strong>#{htmlize title}</strong><p>#{htmlize msg}</p>", :format => :html)
      end
      
      def record_id(id)
        pref = get_pref(id)
        if pref.nil?
          set_pref(id, {})
        end
      end
      
      def notification_ids
        @@prefs.transaction { @@prefs.roots }
      end
      
      def tm_icon
        require 'osx/cocoa'
        OSX::NSImage.alloc().initWithContentsOfFile_(TextMate.app_path + "/Contents/Resources/TextMate.icns")
      end
    end
  end
end
