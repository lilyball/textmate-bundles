module TextMate
  module Notify
    module Mechanism

      def self.all
        require ENV['TM_SUPPORT_PATH'] + '/lib/tm/notify/mechanism/growl'
        require ENV['TM_SUPPORT_PATH'] + '/lib/tm/notify/mechanism/null'
        require ENV['TM_SUPPORT_PATH'] + '/lib/tm/notify/mechanism/tooltip'
        [Null, Tooltip, Growl]
      end

    end
  end
end