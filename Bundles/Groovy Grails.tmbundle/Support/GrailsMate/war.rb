#!/usr/bin/env ruby

require "GrailsMate"

gm = GrailsMate.new("war")
gm.green_patterns << /Created WAR (.)+/
gm.run