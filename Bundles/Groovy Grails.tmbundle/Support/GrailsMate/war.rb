gc = GrailsCommand.new("war")
gc.colorisations['green'] << /Created WAR (.)+/
gc.emit_html