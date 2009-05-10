require ENV['TM_SUPPORT_PATH'] + '/lib/tm/notify/mechanism/base'
             
module TextMate
  module Notify
    module Mechanism
      class Null < Base
    
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
end

