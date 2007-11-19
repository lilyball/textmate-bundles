#!/usr/bin/env ruby

#!/usr/bin/env ruby

require "#{ENV["TM_SUPPORT_PATH"]}/lib/ui"
require "GrailsMate"

gm = GrailsMate.new("create-domain-class") do |default|
  TextMate::UI.request_string( 
    :title => "Create Domain Class",
    :prompt => "Enter the domain class name",
    :default => ""
  )
end

gm.green_patterns << /Created (.)+ for (\w)+/
gm.run