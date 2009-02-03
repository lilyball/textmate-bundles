#/usr/bin/env ruby -w

# wrap in pre tags
puts "<pre>"

# read input (for bmk, stderr must be merged with stdin)
stdin = STDIN.read()

# change any offensive characters to entities
stdin.gsub!('&','&amp;')
stdin.gsub!('<','&lt;')
stdin.gsub!('>','&gt;')
stdin.gsub!('\"','&quot;')
# error to link
stdin.gsub!(/^(Compile Error:.+[\r\n]+\[([^;]*);([0-9]+);([0-9]+)\][\r\n]+Build Error: .+)$/, \
            '<a href="txmt://open/?url=file://\2&line=\3&column=\4">\1</a>')

# spit it out
puts stdin
# wrap in pre tags            
puts "</pre>"
