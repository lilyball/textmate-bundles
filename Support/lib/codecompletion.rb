# Textmate Code Completion
# Version: 7 (version numbers are integers, no beta bologna!)
# 
#  By: Thomas Aylott / subtleGradient, oblivious@
# And: nobody else yet
#   If you make any changes, add your name and be famous! ;)
# 
# (fold)
=begin

README
How to use this version
  Create a tmCommand, input selection or line, output insert as snippet, contents like this:

#!/usr/bin/env ruby
require "#{ENV['TM_SUPPORT_PATH']}/lib/codecompletion"
TextmateCodeCompletion.simple

By default, it'll look for a tmPreference in that bundle with the name "CodeCompletions".
That preference should be like this:

{	completions = ( 'fibbity', 'flabbity', 'floo' ); }

Where the completions is an array of strings.
You can overwrite that by passing in a different name for the preference like this:

TextmateCodeCompletion.simple('SomeOtherNameForMyCompletions')

Or you can use any random plist file like this:

#!/usr/bin/env ruby
require "#{ENV['TM_SUPPORT_PATH']}/lib/codecompletion"
choices = TextmateCompletionsPlist.new('path_to_my_plist_file_of_doom')
print TextmateCodeCompletion.new(choices,STDIN.read).to_s


Or you can just pass in an array manually like so:

#!/usr/bin/env ruby
require "#{ENV['TM_SUPPORT_PATH']}/lib/codecompletion"
print TextmateCodeCompletion.new([ 'fibbity', 'flabbity', 'floo' ],STDIN.read).to_snippet

There's other stuff too, but I got bored with the documentation, haha! take THAT!
=end

# TESTS are in the file codecompletion_test.rb
# Do no commit changes to this file unless all tests pass.
# If you add any functionality, be sure to create tests that really try to break it.
# 
# GOALS:
# 
# Release 1:
#   Just the basics.
#   Grab the choices from a tmPreference plist or an array
#   Filter based on line (allowing for something external to overwrite the method used)
#   Show the menu and select a choice
#   Convert the selection into a snippet
#   Return the snippet to be inserted somehow
#   TextmateCodeCompletion.simple method to allow for really quick and simple default behavior in tmCommands
# 
# Release 2:
#   Support for pure text based completion lists (by file or string).
#   Support for the simple form of plist completions (the same format in TextMate's bundle editor)
# 
# Release 3:
#   New TextmateCompletionsParser class to parse out a text file and return an array of whatever
#   You can pass in a Regexp or an array or Regexps for either the :select or :filter
#   The select thing will use the first Regexp group thing as the replacement pattern
# 
# Release 4:
#   I dunno, fanciness of some sort perhaps
# 
# Eventual goals: 
# 
# Allow for objects as input with snippets as output
# Currently, the choices are simply an Array of strings.
# We will need to extend this eventually to support objects with values that are snippets.
# So you'll select your choice based on the key, but the value of the key/value pair is inserted
# 
# Speed improvements.
# Maybe cache the plists in ram or something
# 
# Line only input.
# Currently we have to do some fancy footwork to insert the right thing in the right way 
# since the input can either be a selection or the current line.
# And if you're input is a selection, then the command only replaces the selection, 
# so you have to make sure you don't reinsert the line and the choice_partial and stuff like that.
# 
# (end)

require "#{ENV['TM_SUPPORT_PATH']}/lib/ui"

class TextmateCodeCompletion
  $debug_codecompletion = {}
  
  EMPTY_ROW = /(^\s*$)/
  
  class << self
    def plist(preference='Completions')
      choices = TextmateCompletionsPlist.new( "#{ENV['TM_BUNDLE_PATH']}/Preferences/#{preference}#{'.tmPreferences' if preference !~ /\./}" )
      print TextmateCodeCompletion.new(choices,STDIN.read).to_snippet
    end
    
    def txt(file='Completions.txt')
      choices = TextmateCompletionsText.new( "#{ENV['TM_BUNDLE_PATH']}/Support/#{file}" )
      print TextmateCodeCompletion.new(choices,STDIN.read).to_snippet
    end
    
    alias :simple :plist
  end
  
  def initialize(choices=nil,line=nil,options={})
    @options = {}
    @options[:characters] = /\w+$/
    
    @options.merge!(options)
    @options.merge!(TextmateCompletionsParser::PARSERS[options[:scope]]) if options[:scope]
    
    @debug = true
    
    @has_selection = ENV['TM_SELECTED_TEXT'] == line
    
    @line = line
    set_line!
    
    cancel() and return if choices.is_a? String
    cancel() and return unless choices and choices.to_ary and !choices.to_ary.empty?
    
    @choices = choices.to_ary
    @choice = false
    
    filter_choices!
    choose() unless @choice
  # rescue
    # cancel()
  end
  
  def choice
    @choice
  end
  
  def index
    @choice_i
  end
  
  def to_snippet
    completion()
  end
  
  private
  def cancel
    @choice = ''
    @cancel = true
  end
  
  def set_line!
    @raw_line = ENV['TM_CURRENT_LINE']
    
    caret_placement()
    
    @line_before = @raw_line[0..caret_placement]
    @line_before = '' if caret_placement == -1
    get_choice_partial!
    @selection      = @line if @has_selection
    @line_after  = @raw_line[caret_placement+1..@raw_line.length+1]
    
    @line_before.gsub!(/#{Regexp.escape @choice_partial}$/,'')
    @line_after.gsub!(/^#{Regexp.escape @selection}/,'') if @selection
    
    if @debug
      $debug_codecompletion["caret_placement"] = caret_placement+2
      $debug_codecompletion["line_before" ] = @line_before
      $debug_codecompletion["choice_partial" ] = @choice_partial
      $debug_codecompletion["selection"      ] = @selection
      $debug_codecompletion["line_after"  ] = @line_after
    end
  end
  
  def caret_placement
    return @caret_placement if @caret_placement
    
    caret_placement = 0
    caret_placement = ENV['TM_COLUMN_NUMBER'].to_i - 2
    caret_placement = ENV['TM_INPUT_START_COLUMN'].to_i - 2 if @has_selection
    
    # Fix those dang tabs being longer than 1 character
    if @raw_line =~ /\t/    
      tabes_to_spaces = ''; ENV['TM_TAB_SIZE'].to_i.times {tabes_to_spaces<<' '}
      
      number_of_tabs_before_cursor = @raw_line.gsub(' ','X').gsub("\t",tabes_to_spaces)[0..caret_placement].gsub(/[^ ]/,'').length / ENV['TM_TAB_SIZE'].to_i
      
      add_to_caret_placement  = 0
      add_to_caret_placement -= number_of_tabs_before_cursor * ENV['TM_TAB_SIZE'].to_i
      add_to_caret_placement += number_of_tabs_before_cursor
      
      caret_placement += add_to_caret_placement
    end
    
    @caret_placement = caret_placement
  end
  
  def get_choice_partial!
    return nil unless @line_before
    
    @choice_partial = @line_before.scan(@options[:characters]).to_s || ''
    if @options[:context]
      match = @line_before.match(@options[:context])
      @strip_partial = match[1].to_s if match
      $debug_codecompletion["match"] = match
    end
    
    $debug_codecompletion["strip"] = @options[:context]
    $debug_codecompletion["strip_partial"] = @strip_partial
  end
  
  def filter_choices!
    cancel() and return if @choices.length == @choices.grep(EMPTY_ROW).length
    
    # Convert the empties to seperators
    # Unless they're the first or last choice
    while @choices.first =~ EMPTY_ROW
      @choices.delete_at(0)
    end
    while @choices.last =~ EMPTY_ROW
      @choices.delete_at(@choices.length-1)
    end
    @choices.each_with_index do |e, i|
      @choices[i] = '--' if e =~ EMPTY_ROW
    end
    
    @choices.each {|e| e.gsub!(@strip_partial,'\1') } if @options[:context] and @strip_partial
    @choices = @choices - @choices.grep(@options[:context]).uniq if @strip_partial
    
    @choices = @choices.grep(/^#{Regexp.escape @choice_partial}/).uniq if @choice_partial #and @choice_partial != ''
    @choices.sort! if @options[:sort] 
  end
  
  def choose
    cancel() and return unless @choices
    if @choices.length == 1
      val = 0
    else
      val = TextMate::UI.menu(@choices)
    end
    cancel() and return unless val
    @choice_i = val
    @choice = @choices[val]
  end
  
  def completion
    $debug_codecompletion["choice"]  = @choice
    $debug_codecompletion["cancel"]  = @cancel
    $debug_codecompletion["choices"] = @choices
    
    completion = ''
    completion << snip(@line_before) unless @has_selection
    if @cancel
      completion << snip(@choice_partial)
      completion << "#{@options[:padding]}${0:#{snip(@selection)}}"
    else
      if @choice
        completion << @options[:padding] unless @line_before.match(/#{Regexp.escape @options[:padding]}$/) if @options[:padding]
        completion << snippetize(@choice) unless @cancel
      else
        completion << snip(@selection) if @selection
      end
    end
    completion << snip(@line_after) unless @has_selection if @line_after
    completion
  end
  
  def snippetize(text)
    text.gsub!(/^#{Regexp.escape @choice_partial}/,'') if @has_selection # Trimoff the choice_partial if we have a selection
    
    snippet = ''
    # snippet << '${101:'
    snippet << snippetize_quotes(snippetize_methods(text))
    # snippet << '}$100'
    snippet << '$0'
    snippet
  end
  
  def snippetize_methods(text)
    text = text.to_s
    @place = 0
    text.gsub!(/([\(,])([^\),]*)/) do |g|
      thing = $2
      "#{$1}${#{@place += 1}:#{snippetize_quotes(thing,true)}}"
    end
    text
  end
  def snippetize_quotes(text,escape=false)
    text = text.to_s
    text = snip(text,escape) if escape
    text.gsub!(/(["'])(?!\$\{)(.*?)(\1)/) do |g|
      thing = $2
      thing1 = $3
      "#{$1}${#{@place += 1}:#{snippetize_quotes(thing,!escape)}}#{thing1}"
    end
    text
  end
  
  def snip(text,escape_bracket=false) #make snippet proof
    chars = /(\$|\`)/
    chars = /(\$|\`|\})/ if escape_bracket
    text.to_s.gsub(chars,'\\\\\\1')
  end
end

class TextmateCompletionsPlist
  require "#{ENV['TM_SUPPORT_PATH']}/lib/osx/plist"
  
  attr :raw, true
  attr :scope, true
  attr :choices, true
  
  def initialize(filepath=nil,options={})
    path = filepath || "#{ENV['TM_BUNDLE_PATH']}/Preferences/CodeCompletion.tmPreferences"
    
    if path.match(/\{/)
      self.raw = path.to_s
      @fullsize = false
    else
      return false unless File.exist?(path)
      self.raw = File.new(path).read
      @fullsize = true
    end
        
    pl = OSX::PropertyList.load(self.raw, true)[0]
    
    self.scope   = pl['scope'].split(/, ?/) if @fullsize and pl['scope']
    self.choices = (@fullsize ? pl['settings'] : pl)['completions']
  end
  
  def to_ary
    self.choices
  end
end

class TextmateCompletionsText
  attr :raw, true
  attr :scope, true
  attr :choices, true
  
  def initialize(path,options={})
    options[:split] ||= "\n"
    
    if path.match(options[:split])
      self.raw = path.to_s
    else
      return false unless File.exist?(path)
      self.raw = File.new(path).read
    end
    
    self.scope   = nil
    self.choices = self.raw.split(options[:split])
    
    self.choices = self.choices - self.choices.grep(options[:filter]) if options[:filter]
  end
  
  def to_ary
    self.choices
  end
end

class TextmateCompletionsParser
  PARSERS = {}
  
  def initialize(filepath=nil, options={})
    unless options[:debug] and filepath.is_a? String
      path = filepath || ENV['TM_FILEPATH']
      return false unless path and File.exist?(path)
      return false if File.directory?(path)
      
      @raw = IO.read(path)
    else
      @raw = filepath
    end
    
    @options = {}
    @options[:split] = "\n"
    
    @options.merge!(options)
    @options.merge!(PARSERS[options[:scope]]) if options[:scope]
    
    @raw = @raw.split(@options[:split])
    
    @filter  = arrayify @options[:filter]
    @selects = arrayify @options[:select]
    collect_selects!
    
    render!()
    @rendered.sort! if @options[:sort]
  end
  
  def to_ary
    @rendered
  end
  
  private
  def render!
    @filter.each do |filter|
      @raw -= @raw.grep(filter)
    end
    
    @rendered = @raw
    @rendered = @raw.grep(@select)
    
    @rendered.each do |r|
      @selects.each do |select|
        r.gsub!(select,'\1')
      end
    end
    
    @rendered -= @rendered.grep(/^\s*$/)
  end
  
  def collect_selects!
    @select = Regexp.new(@selects.collect do |select|
      select.to_s << '|'
    end.to_s.gsub(/\|$/,''))
  end
end

def arrayify(anything)
  anything.is_a?(Array) ? anything : [anything]
end

TextmateCompletionsParser::PARSERS[:css] = {
  :select =>[%r/^([#\.][a-z][-_\w\d]*)\b.*/i, #Ids and Classes
             %r/.*(?:id="(.*?)"|id='(.*?)').*/ #IDs in HTML
            ], 
  :filter =>[%r/^#([0-9a-f]{6}|[0-9a-f]{3})/,
             %r/^..*#.*$/
            ],
  :sort       => true,
  :split      => /[,;\n\s{}]|(\/\*|\*\/)/,
  :characters => /[-_:#\.\w]+$|\.$/
}

TextmateCompletionsParser::PARSERS[:html_attributes] = {
  :sort       => true,
  :characters => /\b\w*$/, 
  :context    => /(<[^\s>]+ )([^>]*(<\B.*?\B>)?)+$/,
  :padding    => ' '
}

TextmateCompletionsParser::PARSERS[:css_values] = {
  :select =>[%r/(url\(.*?\))/,#URLs
             %r/(#([0-9a-f]{6}|[0-9a-f]{3}))/i, #HEX colors
            ],
  :sort   => true,
  :characters => /[#0-9a-z]+$/,
  :split      => /[ :;]/
}

TextmateCompletionsParser::PARSERS[:ruby] = {
  :select =>[%r/^[ \t]*(?:class)\s*(.*?)\s*(<.*?)?\s*(#.*)?$/,
             %r/^[ \t]*(?:def)\s*(.*?(\([^\)]*\))?)\s*(<.*?)?\s*(#.*)?$/,
             %r/^[ \t]*(?:attr_.*?)\s*(.*?(\([^\)]*\))?)\s*(<.*?)?\s*(#.*)?$/
            ], 
  :filter => [/test_/,'< Test::Unit::TestCase']
}

if $0 == __FILE__
  puts "This is a library and cannot be executed directly."
end
