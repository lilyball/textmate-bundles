#!/usr/bin/env ruby

# properly escapes argument for inclusion in a shell command
def e_sh(argument)
	argument.gsub(/([^a-zA-Z0-9_.])/, "\\\\\\1")
end


# properly escapes a string for insertion as a snippet
def e_sn(str)
	str.to_s.gsub(/([}$`\\])/, "\\\\\\1")
end
