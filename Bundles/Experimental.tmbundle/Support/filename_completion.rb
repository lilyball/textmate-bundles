#!/usr/bin/env ruby
line = ENV['TM_CURRENT_LINE']

caret_placement = 0
caret_placement = ENV['TM_COLUMN_NUMBER'].to_i - 2
backContext = line[0..caret_placement]
frontContext = line[caret_placement+1..line.length+1]

backContext.gsub!(/#{Regexp::escape(ENV['TM_SELECTED_TEXT'])}$/,'') if ENV['TM_SELECTED_TEXT']
backContext.match(/\s*(([^ ]*(\\ )?)*)$/)
context = $1

words_tmp = `ls -AdFH #{context}* 2>/dev/null`.split("\n")

context = `ls -AdFH #{context.gsub(/\/$/,'')}`.gsub(/^#{Regexp::escape(ENV['HOME'])}/,'~').chomp if context.match(/\/$/) unless context == '/'
context.gsub!(/\\(.)/,'\1')

words = [context]
words << nil
words_tmp.each do |w|
  w.gsub!(/^#{Regexp::escape(ENV['HOME'])}/,'~')
  w.gsub!(/^#{Regexp::escape(context)}/,'') if context
  words << w if w and w != ''
end

begin
  require ENV['TM_SUPPORT_PATH'] + "/lib/ui"
  abort if words.empty?

  val = TextMate::UI.menu(words)
  val = words[val] if val
  
  val = nil if val == context
  
  if val
    print "${2:"
    # print '/' unless context.match(/\/$/) or val.match(/^\//)
    val.gsub!(/^#{Regexp::escape(context)}/,'')
    val.gsub!(/^#{Regexp::escape(context)}/,'')
    val.gsub!(/( |\')/,'\\\\\1')
    val.gsub!(/(@|\*)$/,'')
    print val
    print "}$1$0"
  else
    print "${1:#{ENV['TM_SELECTED_TEXT']}}$0" if ENV['TM_SELECTED_TEXT']
  end
# rescue
#   nil
end
