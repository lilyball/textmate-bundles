# 
# Textmate Code Completion
# Version: 3 (version numbers are integers, no beta bologna!)
# 
#  By: Thomas Aylott / subtleGradient, oblivious@
# And: nobody else yet
#   If you make any changes, add your name and be famous! ;)
# 

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
#   Filter based on context (allowing for something external to overwrite the method used)
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
# Currently, the choices are simple an Array of strings.
# We will need to extend this eventually to support objects with values that are snippets.
# So you'll select your choice based on the key, but the calue of the key/value pair is inserted
# 
# Speed improvements.
# Maybe cache the plists in ram or something
# 
# Line only input.
# Currently we have to do some fancy footwork to insert the right thing in the right way 
# since the input can either be a selection or the current line.
# And if you're input is a selection, then the command only replaces the selectio, 
# so you have to make sure you don't reinsert the context and the choice_partial and stuff like that.
# 
# 

require "#{ENV['TM_SUPPORT_PATH']}/lib/dialog"

class TextmateCodeCompletion
  
  class << self
    def plist(preference='Completions')
      choices = TextmateCompletionsPlist.new( "#{ENV['TM_BUNDLE_PATH']}/Preferences/#{preference}.tmPreferences" )
      print TextmateCodeCompletion.new(choices,STDIN.read).to_snippet
    end
    
    def txt(file='Completions.txt')
      choices = TextmateCompletionsText.new( "#{ENV['TM_BUNDLE_PATH']}/Support/#{file}" )
      print TextmateCodeCompletion.new(choices,STDIN.read).to_snippet
    end
    
    alias :simple :plist
  end
  
  def initialize(choices=nil,context=nil)
    @debug = true
    
    @has_selection = ENV['TM_SELECTED_TEXT'] == context
    
    @context = context
    set_context!()
    
    cancel() and return unless choices and !choices.to_ary.empty?
    
    @choices = choices.to_ary
    @choice = false
    
    filter_choices!()
    choose() unless @choice
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
  
  def set_context!
    line = ENV['TM_CURRENT_LINE']
    
    caret_placement = 0
    caret_placement = ENV['TM_COLUMN_NUMBER'].to_i - 2
    caret_placement = ENV['TM_INPUT_START_COLUMN'].to_i - 2 if @has_selection
    @context_before = line[0..caret_placement]
    @context_before = '' if caret_placement == -1
    @choice_partial = get_choice_partial()
    @selection      = @context if @has_selection
    @context_after  = line[caret_placement+1..line.length+1]
    
    @context_before.gsub!(/#{Regexp.escape @choice_partial}$/,'')
    @context_after.gsub!(/^#{Regexp.escape @selection}/,'') if @selection
    
    
    
    if @debug
      $debug_codecompletion = {}
      $debug_codecompletion["caret_placement"] = snip caret_placement+2
      $debug_codecompletion["context_before" ] = snip @context_before
      $debug_codecompletion["choice_partial" ] = snip @choice_partial
      $debug_codecompletion["selection"      ] = snip @selection
      $debug_codecompletion["context_after"  ] = snip @context_after
    end
  end
  
  def get_choice_partial
    return nil unless @context_before
    
    choice_partial  = ''
    choice_partial  = @context_before.scan(/\w+$/)
    choice_partial.to_s
  end
  
  def filter_choices!
    @choices = @choices.grep(/^#{Regexp.escape @choice_partial}/).uniq if @choice_partial
  end
  
  def choose
    cancel() and return unless @choices
    
    val = Dialog.menu(@choices)
    cancel() and return unless val
    @choice_i = val
    @choice = @choices[val]
  end
  
  def completion
    $debug_codecompletion["choice"] = snip @choice
    
    completion = ''
    completion << snip(@context_before) unless @has_selection
    if @cancel
      completion << snip(@choice_partial)
      completion << "${0:#{snip(@selection)}}"
    else
      if @choice
        completion << snippetize(@choice)
      else
        completion << snip(@selection) if @selection
      end
    end
    completion << snip(@context_after) unless @has_selection
    completion
  end
  
  def snippetize(text)
    text.gsub!(/^#{Regexp.escape @choice_partial}/,'') if @has_selection # Trimoff the choice_partial if we have a selection
    
    snippet = ''
    snippet << '${101:'
    snippet << snippetize_methods(snip(text))
    snippet << '}$100$0'
    snippet
  end
  
  def snippetize_methods(text)
    text = text.to_s
    place = 0
    text.gsub!(/([\(,])([^\),]*)/) do |g|
      "#{$1}${#{place += 1}:#{$2}}"
    end
    text
  end
  
  def snip(text) #make snippet proof
    text.to_s.gsub(/(\$|\`)/,'\\\\\\1') if text
  end
end

class TextmateCompletionsPlist
  require "#{ENV['TM_SUPPORT_PATH']}/lib/plist"
  
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
        
    pl = PropertyList.load(self.raw, true)[0]
    
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
    options[:split] = "\n" unless options[:split]
    
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
    path = filepath || ENV['TM_FILEPATH']
    return false unless path and File.exist?(path)
    return false if File.directory?(path)
    
    @raw = IO.readlines(path)
    
    options = PARSERS[options[:scope]].merge(options) if options[:scope]
    
    @filter  = arrayify options[:filter]
    @selects = arrayify options[:select]
    collect_selects!
    
    render!()
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

TextmateCompletionsParser::PARSERS[:ruby] = {
  :select => [/^[ \t]*(?:class)\s*(.*?)\s*(<.*?)?\s*(#.*)?$/,
              /^[ \t]*(?:def)\s*(.*?(\([^\)]*\))?)\s*(<.*?)?\s*(#.*)?$/,
              /^[ \t]*(?:attr_.*?)\s*(.*?(\([^\)]*\))?)\s*(<.*?)?\s*(#.*)?$/], 
  :filter => [/test_/,'< Test::Unit::TestCase']
}
# TextmateCompletionsParser::PARSERS[:rails] = {
#   :select => TextmateCompletionsParser::PARSERS[:ruby][:select],
#   :filter => TextmateCompletionsParser::PARSERS[:ruby][:filter]
# }
