# escape text to make it useable in a shell script as one “word” (string)
def e_sh(str)
	str.to_s.gsub(/(?=[^a-zA-Z0-9_.\/\-\x7F-\xFF\n])/, '\\').gsub(/\n/, "'\n'")
end

# escape text for use in a TextMate snippet
def e_sn(str)
	str.to_s.gsub(/(?=[$`\\])/, '\\')
end

# escape text for use in an AppleScript string
def e_as(str)
	str.to_s.gsub(/(?=["\\])/, '\\')
end

# URL escape a string but preserve slashes (idea being we have a file system path that we want to use with file://)
def e_url(str)
  str.gsub(/([^a-zA-Z0-9\/_.-]+)/n) do
    '%' + $1.unpack('H2' * $1.size).join('%').upcase
  end
end

# Make string suitable for display as HTML, preserve spaces
def htmlize(str)
  str = str.to_s.gsub("&", "&amp;").gsub("<", "&lt;")
  str = str.gsub(/\t+/, '<span style="white-space:pre;">\0</span>')
  str = str.reverse.gsub(/ (?= |$)/, ';psbn&').reverse
  str.gsub("\n", "<br>")
end
