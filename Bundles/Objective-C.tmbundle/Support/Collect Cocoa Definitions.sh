
# Cocoa Functions
find /System/Library/Frameworks/{AppKit,Foundation}.framework -name \*.h -exec grep '^[A-Z][A-Z_]* .* NS[A-Z][A-Za-z]*\s*(' '{}' \;|perl -pe 's/.*?\s(\w+)\s*\(.*/$1/'|sort|uniq|wc -l

# Cocoa Classes
find /System/Library/Frameworks/{AppKit,Foundation}.framework -name \*.h -exec grep '@interface NS[A-Za-z]*' '{}' \;|perl -pe 's/.*?(NS[A-Za-z]+).*/$1/'|sort|uniq

# Cocoa Protocols
find /System/Library/Frameworks/{AppKit,Foundation}.framework -name \*.h -exec grep '@protocol NS[A-Za-z]*' '{}' \;|perl -pe 's/.*?(NS[A-Za-z]+).*/$1/'|sort|uniq

# Cocoa Types
find /System/Library/Frameworks/{AppKit,Foundation}.framework -name \*.h -exec grep 'typedef .* _*NS[A-Za-z]*' '{}' \;|perl -pe 's/.*?(NS[A-Za-z]+);.*/$1/'|perl -pe 's/typedef .*? _?(NS[A-Za-z0-9]+) \{.*/$1/'|grep -v typedef|sort|uniq

