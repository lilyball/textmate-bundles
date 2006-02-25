#!/usr/bin/env ruby

snippets = {
  'rename_column' =>
    { :up   =>  %Q{rename_column "${1:table}", "${2:column}", "${3:new_name}"$0},
      :down =>  'rename_column "$1", "$3", "$2"' },
  
  'add_remove_column' =>
    { :up   =>  'add_column "${1:table}", "${2:column}", :${3:string}',
      :down =>  'remove_column "$1", "$2"' },

  'create_drop_table' =>
    { :up   =>  "create_table \"${1:table}\" do |t|\n  $0\nend",
      :down =>  'drop_table "$1"' }    
}



def self.up
end

def self.down
end

# add tab_size spaces to the indent level of line
def indent(line)
  line =~ /^(\s*)/
  ' ' * ($1.length + ENV['TM_TAB_SIZE'])
end

class String
  # Gets the line number of character +i+ (0-base index)
  def line_from_index(i)
    slice(0..i).count("\n")
  end
  
  # Gets the index of the beginning of line number +l+ (0-base index)
  def index_from_line(l)
    to_a.slice(0...l).join.length
  end

  def next_line_with_matching_indent(block_beginning_line)
    lines = to_a
    indentation = lines[block_beginning_line].scan(/^(\s*)/).flatten.first
    lines.slice(block_beginning_line + 1, lines.size).each_with_index do |line, index|
      return block_beginning_line + index + 1 if line =~ /^#{indentation}[^\s]/
    end
    raise "Match not found"
  rescue
    return nil
  end
end

def escape(text)
  text.gsub('([$`\\])', '\\\\\1')
end

def intelligently_insert_migration(snippet, text)
  # differentiate these $'s so we can unescape
  up_code = snippet[:up].gsub('\$', '$$')
  down_code = snippet[:down].gsub('\$', '$$')
  # find the end of self.down and insert 2nd line
  lines = text.to_a.reverse
  ends_seen = 0
  lines.each_with_index do |line, i|
    ends_seen += 1    if line =~ /^\s*end\b/
    if ends_seen == 2
        lines[i..i] = [lines[i], indent(lines[i]) + down_code + "\n"]
      break
    end
  end

  # escape special chars, replace \$\$ with $ in snippets, and return
  #(up_code + lines.reverse.to_s).gsub('([$`\\])', '\\\\\1').gsub('\$\$', '$')
end

if snippets.has_key? ARGV[0]
  print intelligently_insert_migration(snippets[ARGV[0]], STDIN.read)
end
