require ENV['TM_SUPPORT_PATH'] + '/lib/tm/notify/preferences'
require ENV['TM_SUPPORT_PATH'] + '/lib/tm/notify/mechanism'

module TextMate
  module Notify
    class Notification
    
      def initialize(data)
        @data = data
      end
    
      def name
        @data["name"]
      end
    
      def mechanism
        Mechanism.all.find { |t| @data["mechanism"]["code"] == t.code }
      end
    
      def scope_selector
        @data["scope_selector"] || ""
      end
    
      def fire(scope, title, msg)
        mechanism.new(scope, self, title, msg).fire
      end
      
      def self.all
        Notify::Preferences.notifications
      end
      
    end
  end
end