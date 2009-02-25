gc = GrailsCommand.new("war")
gc.colorisations['green'] << /Created WAR (.)+/
gc.run