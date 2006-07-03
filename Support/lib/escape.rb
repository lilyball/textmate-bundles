# escape text to make it useable in a shell script as one “word” (string)
def e_sh(str)
	str.to_s.gsub(/[^a-zA-Z0-9_.]/, "\\\\\\0")
end

# escape text for use in a TextMate snippet
def e_sn(str)
	str.to_s.gsub(/[$`\\]/, "\\\\\\0")
end

# escape text for use in an AppleScript string
def e_as(str)
	str.to_s.gsub(/["\\]/, "\\\\\\0")
end

# URL escape a string but preserve slashes (idea being we have a file system path that we want to use with file://)
def e_url(str)
  str.gsub(/([^a-zA-Z0-9\/_.-]+)/n) do
    '%' + $1.unpack('H2' * $1.size).join('%').upcase
  end
end
