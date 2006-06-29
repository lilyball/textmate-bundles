#!/usr/bin/env ruby

# properly escapes argument for inclusion in a shell command
def e_sh(argument)
	argument.gsub(/[^a-zA-Z0-9_.]/, "\\\\\\0")
end

# properly escapes a string for insertion as a snippet
def e_sn(str)
	str.to_s.gsub(/[$`\\]/, "\\\\\\0")
end

# URL escape a string but preserve slashes (idea being we have a file system path that we want to use with file://)
def e_url(str)
  str.gsub(/([^a-zA-Z0-9\/_.-]+)/n) do
    '%' + $1.unpack('H2' * $1.size).join('%').upcase
  end
end