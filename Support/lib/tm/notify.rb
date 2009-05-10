require ENV['TM_SUPPORT_PATH'] + '/lib/tm/notify/growl'
require ENV['TM_SUPPORT_PATH'] + '/lib/textmate'
require ENV['TM_SUPPORT_PATH'] + '/lib/ui'
require ENV['TM_SUPPORT_PATH'] + '/lib/escape'
require ENV['TM_SUPPORT_PATH'] + '/lib/osx/plist'

module TextMate
  
  class << self
    def notify(scope, title, msg)
      Notification.new(scope, title, msg).notify
    end
  end
  
  class Notification

    attr_reader :scope, :title, :msg, :pref
    
    def initialize(scope, title, msg)
      @scope = scope
      @title = title
      @msg = msg
      @pref = Preferences[scope] # ensures that we are in the preferences (needed for Preferences.notification_ids)
    end
    
    def growl_available?
      %x{ps -xwwco "command" | grep -sq '^GrowlHelperApp$'}
      $? == 0
    end
    
    def should_growl?
      @pref.growl? and growl_available?
    end
    
    def notify
      should_growl? ? growl : tooltip
    end

    def growl
      n_ids = Preferences.growl_notifications
      growl = GrowlNotifier.new("TextMate", n_ids, n_ids, icon)
      growl.register
      growl.notify(pref.name, title, msg)
      self
    end

    def tooltip
      TextMate::UI.tool_tip("<strong>#{htmlize title}</strong><p>#{htmlize msg}</p>", :format => :html)
      self
    end
    
    def icon
      require 'osx/cocoa'
      OSX::NSImage.alloc().initWithContentsOfFile_(TextMate.app_path + "/Contents/Resources/TextMate.icns")
    end
    
    class Preference
      
      @@keys ={
        :notifier => "notifier",
        :name => "name"
      } 
      
      def self.keys
        @@keys
      end
      
      @@notifiers = {
        :growl => {"code" => "growl", "name" => "Growl"},
        :tooltip => {"code" => "tooltip", "name" => "Tool Tip"},
        :none => {"code" => "none", "name" => "None"}
      }
      
      def self.notifiers
        @@notifiers
      end
      
      def initialize(data)
        if data.nil?
          @data = {
            @@keys[:notifier] => Preference.notifiers[:tooltip]
          }
        else
          @data = data
        end
      end
      
      def name
        @data[Preference.keys[:name]]
      end
      
      def none?
        @data[Preference.keys[:notifier]] == Preference.notifiers[:none]
      end
      
      def tooltip?
        @data[Preference.keys[:notifier]] == Preference.notifiers[:tooltip]
      end
      
      def growl?
        @data[Preference.keys[:notifier]] == Preference.notifiers[:growl]
      end
      
    end
    
    module Preferences
      class  << self
        
        @@notifications_key = "notifications"
        @@defaults_key = "defaults"
        
        @@filename = File.expand_path "~/Library/Preferences/com.macromates.textmate.notifications.plist"
        @@prefs = nil
        
        def read
          if File.exists? @@filename
            File.open(@@filename, "r") do |f|
              @@prefs = OSX::PropertyList.load(f)
            end
          else
            @@prefs = {
              @@notifications_key => []
            }
          end
        end
        
        def save
          File.open(@@filename, "w+") do |f|
            f << @@prefs.to_plist
          end
        end
        
        def notifications
          @@prefs[@@notifications_key]
        end
        
        def [](scope_selector) 
          n = notifications.find { |n| n["scope_selector"] == scope_selector }
          Preference.new(n)
        end
        
        def growl_notifications
          notifications.find_all { |n| n[Preference.keys[:notifier]] == Preference.notifiers[:growl] }.collect { |n| n[Preference.keys[:name]] }
        end
        
        def show
          TextMate::UI.dialog(
            :nib => ENV['TM_SUPPORT_PATH'] + '/nibs/NotificationPreferences.nib', 
            :parameters => {
              "preferences" => @@prefs,
              "notifiers" => Preference.notifiers.values
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
