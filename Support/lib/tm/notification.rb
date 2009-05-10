require ENV['TM_SUPPORT_PATH'] + '/lib/tm/notification/preferences'

module TextMate
  module Notification
    class << self
      
      def types 
        require ENV['TM_SUPPORT_PATH'] + '/lib/tm/notification/growl'
        require ENV['TM_SUPPORT_PATH'] + '/lib/tm/notification/null'
        require ENV['TM_SUPPORT_PATH'] + '/lib/tm/notification/tooltip'
        [Null, Tooltip, Growl]
      end
      
      def all
        Preferences.configurations
      end
      
    end
  end
end