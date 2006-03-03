#!/usr/bin/env ruby
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/rails_bundle_tools'

def prepend(text, prefix)
  text.to_a.map { |line| prefix + line }.join
end

def unprepend(text, prefix)
  text.to_a.map { |line| line.sub(prefix, '') }.join
end

buffer = Buffer.new(STDIN.read, 0, 0)

if buffer.lines[0] =~ /drop_table\s+['"](\w+)['"]/
  table_name = $1
  
  # Find 'self.down' method and matching 'end'
  if self_down = buffer.find { /^(\s*)def self\.down\b/ }
    indentation = self_down[0]
    self_down_end = buffer.find(:from => (self_down[1] + 1)) { %r{^#{indentation}end\b} }

    schema = RailsPath.new('db/schema.rb')
    if schema.exists?
      if create_table = schema.buffer.find { %r{^(\s*)create_table\s+["']#{table_name}['"]} }
        create_table_indentation = create_table[0]
        create_table_end = schema.buffer.find(:from => (create_table[1] + 1)) { %r{^#{indentation}end\b} }
    
        create_table = unprepend(schema.buffer.lines[create_table[1]..create_table_end[1]], create_table_indentation)
        buffer.lines.insert self_down_end[1], prepend("\n" + create_table, indentation + "  ")
        print buffer.lines.join.gsub("[press tab twice to generate create_table]", "")
      else
        puts "The db/schema.rb does not have a create_table \"#{table_name}\"."
        TextMate.exit_show_tool_tip
      end
    else
      puts "The db/schema.rb file doesn't exist.  Can't insert create_table."
      TextMate.exit_show_tool_tip
    end
  else
    puts "No self.down method found in below the caret."
    TextMate.exit_show_tool_tip
  end
else
  puts "No table name specified. (\"#{buffer.lines[0]}\")"
  TextMate.exit_show_tool_tip
end