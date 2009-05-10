require ENV['TM_SUPPORT_PATH'] + '/lib/tm/notification/base'
             
module TextMate
  module Notification
    class Null < TextMate::Notification::Base
    
      def self.name
        "None"
      end
    
      def self.code
        "none"
      end
    
      def fire

      end
      
    end
  end
end

