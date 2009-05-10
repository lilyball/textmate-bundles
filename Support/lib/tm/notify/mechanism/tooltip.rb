require ENV['TM_SUPPORT_PATH'] + '/lib/tm/notify/mechanism/base'
require ENV['TM_SUPPORT_PATH'] + '/lib/ui'
             
module TextMate
  module Notify
    module Mechanism
      class Tooltip < Base
    
        def self.name
          "Tool Tip"
        end
    
        def self.code
          "tooltip"
        end
    
        def fire
          TextMate::UI.tool_tip("<strong>#{htmlize title}</strong><p>#{htmlize msg}</p>", :format => :html)
        end

      end
    end
  end
end

