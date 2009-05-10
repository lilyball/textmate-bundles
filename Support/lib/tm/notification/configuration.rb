require ENV['TM_SUPPORT_PATH'] + '/lib/tm/notification'
require ENV['TM_SUPPORT_PATH'] + '/lib/tm/notification/preferences'

module TextMate
  module Notification
    class Configuration
    
      def initialize(data)
        @data = data
      end
    
      def name
        @data["name"]
      end
    
      def notification_type
        Notification.types.find { |t| @data["type"]["code"] == t.code }
      end
    
      def scope_selector
        @data["scope_selector"] || ""
      end
    
      def fire(scope, title, msg)
        notification_type.new(scope, self, title, msg).fire
      end
      
    end
  end
end