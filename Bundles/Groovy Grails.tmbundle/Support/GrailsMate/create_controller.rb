gm = GrailsMate.new("create-controller") do |default|
  TextMate::UI.request_string( 
    :title => "Create Controller",
    :prompt => "Enter the controller name",
    :default => ""
  )
end

gm.colorisations['green'] << /Created (\w)+ for (\w)+/
gm.emit_html