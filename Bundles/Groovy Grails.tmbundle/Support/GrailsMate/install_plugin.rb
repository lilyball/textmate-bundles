gm = GrailsMate.new("install-plugin") do |default|
  TextMate::UI.request_string( 
    :title => "Install Grails Plug-in",
    :prompt => "Enter the Plug-in name",
    :default => ""
  )
end

gm.colorisations['green'] << /Plugin (.)+ installed/
gm.colorisations['red'] << /Plugin (.)+ was not found in repository/
gm.emit_html