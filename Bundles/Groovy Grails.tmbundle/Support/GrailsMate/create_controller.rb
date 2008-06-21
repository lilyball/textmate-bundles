gc = GrailsCommand.new("create-controller") do |default|
  TextMate::UI.request_string( 
    :title => "Create Controller",
    :prompt => "Enter the controller name",
    :default => ""
  )
end

gc.colorisations['green'] << /Created (\w)+ for (\w)+/
gc.run