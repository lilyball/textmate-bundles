gc = GriffonCommand.new("install-plugin") do |default|
  TextMate::UI.request_string( 
    :title => "Install Griffon Plug-in",
    :prompt => "Enter the Plug-in name",
    :default => ""
  )
end

gc.colorisations['green'] << /Plugin (.)+ installed/
gc.colorisations['red'] << /Plugin (.)+ was not found in repository/
gc.run