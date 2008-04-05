gm = GrailsMate.new("create-domain-class") do |default|
  TextMate::UI.request_string( 
    :title => "Create Domain Class",
    :prompt => "Enter the domain class name",
    :default => ""
  )
end

gm.colorisations['green'] << /Created (.)+ for (\w)+/
gm.emit_html