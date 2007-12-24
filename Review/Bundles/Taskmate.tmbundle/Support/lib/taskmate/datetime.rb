require 'date'

class DateTime
  class << self
    alias parse_without_format_workaround parse 
    
    def parse(str='-4712-01-01T00:00:00Z', *args)
      parse_without_format_workaround str.gsub('.', '-') #, *args
    end
  end
end

