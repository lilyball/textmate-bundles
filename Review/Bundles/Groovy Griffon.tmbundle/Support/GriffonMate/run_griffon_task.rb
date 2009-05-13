gc = GriffonCommand.new("") do |default|
  TextMate::UI.request_string( 
    :title => "Run def Griffon(args)
      
    end
     Task",
    :prompt => "Enter a command to pass to griffon",
    :default => default
  )
end

gc.run