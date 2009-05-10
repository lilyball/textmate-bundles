module TextMate
  module Notification
    
    class Base
      
      attr_reader :scope, :conf, :title, :msg
      
      def initialize(scope, conf, title, msg)
        @scope = scope
        @title = title
        @msg = msg
        @conf = conf
      end
      
      def name 
        conf.name
      end
      
    end
    
  end
end