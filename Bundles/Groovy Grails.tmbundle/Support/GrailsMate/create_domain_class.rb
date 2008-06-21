gc = GrailsCommand.new("create-domain-class") do |default|
  TextMate::UI.request_string( 
    :title => "Create Domain Class",
    :prompt => "Enter the domain class name",
    :default => ""
  )
end

gc.colorisations['green'] << /Created (.)+ for (\w)+/
gc.run