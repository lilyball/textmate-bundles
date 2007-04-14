#!/usr/bin/env ruby
# 
# CodeCompletion TESTS
# 
require "#{ENV['TM_SUPPORT_PATH']}/lib/codecompletion"
require 'test/unit'

puts "\nJust keep hittin' 1\n\n"

class TextmateCodeCompletionTest < Test::Unit::TestCase
  def test_blank
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "", "TM_COLUMN_NUMBER" => "1", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal "test$0", TextmateCodeCompletion.new(['test']).to_snippet
  end
  def test_basic
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "basic", "TM_COLUMN_NUMBER" => "6", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal "basic$0", TextmateCodeCompletion.new(['basic'], %{basic}).to_snippet
  end
  
  def test_a
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "a", "TM_COLUMN_NUMBER" => "2", "TM_INPUT_START_COLUMN" => "1"})
    tcc = TextmateCodeCompletion.new(['aaa'], %{a})
    assert_equal "aaa$0", tcc.to_snippet  , $debug_codecompletion.inspect
    assert_equal 0, tcc.index             , $debug_codecompletion.inspect
    assert_equal 'aaa', tcc.choice        , $debug_codecompletion.inspect
  end
  
  def test_choices
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "\t", "TM_COLUMN_NUMBER" => "3", "TM_BUNDLE_PATH" => "#{ENV['TM_BUNDLE_PATH']}../CSS.tmbundle", "TM_INPUT_START_COLUMN" => "1"})
    
    TextmateCodeCompletion.new([' ','  ','real1','   ','real2','    '],  "\t").to_snippet
    assert_equal '--', $debug_codecompletion['choices'][1], $debug_codecompletion.inspect
    assert_equal 3, $debug_codecompletion['choices'].length, $debug_codecompletion.inspect
    
    assert_equal "\t${0:}", TextmateCodeCompletion.new('',    "\t").to_snippet, $debug_codecompletion.inspect
    assert_equal "\t${0:}", TextmateCodeCompletion.new(nil,   "\t").to_snippet, $debug_codecompletion.inspect
    assert_equal "\t${0:}", TextmateCodeCompletion.new([nil], "\t").to_snippet, $debug_codecompletion.inspect
    assert_equal "\t${0:}", TextmateCodeCompletion.new([''],  "\t").to_snippet, $debug_codecompletion.inspect
  end
  
  def test_in_snippet
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => %{${1:snippet}}, "TM_COLUMN_NUMBER" => "12", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal '\${1:snippet${0:}}', TextmateCodeCompletion.new(['nomatch'], %{${1:snippet}}).to_snippet
  end
  def test_in_snippet_match
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => %{${1:snippet}}, "TM_COLUMN_NUMBER" => "12", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal '\${1:snippet$0}', TextmateCodeCompletion.new(['snippet'], %{${1:snippet}}).to_snippet
  end
  
  def test_choice_partial_selection
    set_tm_vars({"TM_SELECTED_TEXT" => "selection", "TM_CURRENT_LINE" => "choice_partialselection", "TM_COLUMN_NUMBER" => "24", "TM_INPUT_START_COLUMN" => "15"})
    assert_equal "choice_partial${0:selection}", TextmateCodeCompletion.new(['test'], %{selection}).to_snippet, $debug_codecompletion.inspect
  end
  def test_choice_partial_selection_match
    set_tm_vars({"TM_SELECTED_TEXT" => "selection", "TM_CURRENT_LINE" => "choice_partialselection", "TM_COLUMN_NUMBER" => "24", "TM_INPUT_START_COLUMN" => "15"})
    assert_equal "_match$0", TextmateCodeCompletion.new(['choice_partial_match'], %{selection}).to_snippet, $debug_codecompletion.inspect
  end
  
  def test_selection_no_context
    set_tm_vars({"TM_SELECTED_TEXT" => "basic_selection", "TM_CURRENT_LINE" => "basic_selection", "TM_COLUMN_NUMBER" => "1", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal "test_selection$0", TextmateCodeCompletion.new(['test_selection'], %{basic_selection}).to_snippet, $debug_codecompletion.inspect
  end
  
  def test_snippetize
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "String", "TM_COLUMN_NUMBER" => "7", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal "String.method(${1:})$0", TextmateCodeCompletion.new(['String.method()'], %{String}).to_snippet, $debug_codecompletion.inspect
  end
  
  def test_snippetize_methods
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "String", "TM_COLUMN_NUMBER" => "7", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal "String.method(${1:one},${2:two})(${3:})$0", TextmateCodeCompletion.new(['String.method(one,two)()'], %{String}).to_snippet, $debug_codecompletion.inspect
  end
  def test_snippetize_methods_with_stuff
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "change_column", "TM_COLUMN_NUMBER" => "14", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal 'change_column(${1:table_name},${2: column_name},${3: type},${4: options = {\}})$0', TextmateCodeCompletion.new([%{change_column(table_name, column_name, type, options = {})}],'').to_snippet, $debug_codecompletion.inspect
  end
  def test_snippetize_bracket_escaping
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "{before} {inside} {after}", "TM_COLUMN_NUMBER" => "14","TM_INPUT_START_COLUMN" => "1"})
    assert_equal %{{before} {ins${0:}ide} {after}}, TextmateCodeCompletion.new(['test'], %{{before} {inside} {after}}).to_snippet, $debug_codecompletion.inspect
  end
  
  def test_spaces
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "  padding-top: 1px;", "TM_COLUMN_NUMBER" => "10", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal "  padding_is_awesome$0-top: 1px;", TextmateCodeCompletion.new(['padding_is_awesome'], %{  padding-top: 1px;}).to_snippet, $debug_codecompletion.inspect
  end
  def test_tabs
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "\t\t\t\tpadding-top: 1px;", "TM_COLUMN_NUMBER" => "16", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal "\t\t\t\tpadding_is_awesome$0-top: 1px;", TextmateCodeCompletion.new(['padding_is_awesome'], "\t\t\t\tpadding-top: 1px;").to_snippet, $debug_codecompletion.inspect
    
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "\tpadding-top: 1px;", "TM_COLUMN_NUMBER" => "10", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal "\tpadding_is_awesome$0-top: 1px;", TextmateCodeCompletion.new(['padding_is_awesome'], %{	padding-top: 1px;}).to_snippet, $debug_codecompletion.inspect
    
    # Make sure it's not also recalculating the tabs after the cursor position
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "\t\t\t\tpadding\t\t\t\t-top: 1px;", "TM_COLUMN_NUMBER" => "16", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal "\t\t\t\tpadding_is_awesome$0\t\t\t\t-top: 1px;", TextmateCodeCompletion.new(['padding_is_awesome'], "\t\t\t\tpadding\t\t\t\t-top: 1px;").to_snippet, $debug_codecompletion.inspect
    
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "\tpadding\t\t\t\t-top: 1px;", "TM_COLUMN_NUMBER" => "10", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal "\tpadding_is_awesome$0\t\t\t\t-top: 1px;", TextmateCodeCompletion.new(['padding_is_awesome'], "\tpadding\t\t\t\t-top: 1px;").to_snippet, $debug_codecompletion.inspect
  end
  
  def test_extra_word_characters
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => ".", "TM_COLUMN_NUMBER" => "2", "TM_INPUT_START_COLUMN" => "1"})
    tcc = TextmateCodeCompletion.new(['.aaa'], %{.}, {:characters => /[-_:#\.\w]/})
    assert_equal ".aaa$0", tcc.to_snippet  , $debug_codecompletion.inspect
    assert_equal 0, tcc.index             , $debug_codecompletion.inspect
    assert_equal '.aaa', tcc.choice        , $debug_codecompletion.inspect
  end
  
end

class TextmateCompletionsPlistTest < Test::Unit::TestCase
  def test_plist
    completions = TextmateCompletionsPlist.new(
      "#{ENV['TM_SUPPORT_PATH']}/../Bundles/Objective-C.tmbundle/Preferences/Cocoa completions.plist"
    )
    assert_not_nil completions
    assert_kind_of Array, completions.to_ary
    assert completions.to_ary.length > 0
  end
  def test_plist_string
    completions = TextmateCompletionsPlist.new("{	completions = ( 'fibbity', 'flabbity', 'floo' ); }")
    assert_not_nil completions
    assert_kind_of Array, completions.to_ary
    assert completions.to_ary.length == 3, completions.choices
  end
end

class TextmateCompletionsTextTest < Test::Unit::TestCase
  def test_txt
    completions = TextmateCompletionsText.new("README.txt")
    assert_not_nil completions
    assert_kind_of Array, completions.to_ary
    assert completions.to_ary.length > 0
  end
  def test_txt_completions
    completion = TextmateCodeCompletion.new(TextmateCompletionsText.new("README.txt"),'').to_snippet
    assert_not_nil completion
  end
  def test_txt_completions_dict
    completions = TextmateCompletionsText.new(`cat /usr/share/dict/web2|grep ^fr`).to_ary
    completion = TextmateCodeCompletion.new(completions,'fra').to_snippet
    assert_not_nil completion
  end
  def test_strings
    them = %{one\ntwo\nthree}
    
    completions = TextmateCompletionsText.new(them)
    assert_not_nil completions
    assert_kind_of Array, completions.to_ary
    assert completions.to_ary.length == 3
    
    them = %{one,two,three}
    
    completions = TextmateCompletionsText.new(them, :split => ',')
    assert_not_nil completions
    assert_kind_of Array, completions.to_ary
    assert completions.to_ary.length == 3
    
    them = %{one,two,three}
    
    completions = TextmateCompletionsText.new(them, :split => ',', :filter => /three/)
    assert_not_nil completions
    assert_kind_of Array, completions.to_ary
    assert completions.to_ary.length == 2
  end
end

class TextmateCompletionsParserTest < Test::Unit::TestCase
  def test_parser_dir
    fred = TextmateCompletionsParser.new(File.dirname(__FILE__), :select => /^[ \t]*(?:class|def)\s*(.*?)\s*(<.*?)?\s*(#.*)?$/).to_ary
    assert_nil fred
  end
  def test_parser_symbol
    fred = TextmateCompletionsParser.new(nil, :scope => :ruby).to_ary
    assert_kind_of Array, fred.to_ary
    assert fred.to_ary.length > 0, fred.inspect
    
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "a", "TM_COLUMN_NUMBER" => "2", "TM_INPUT_START_COLUMN" => "1"})
    assert_not_nil TextmateCodeCompletion.new(fred).to_snippet
  end
  def test_parser_array
    fred = TextmateCompletionsParser.new(nil, 
      :split => "\n",
      :select => [%r/^[ \t]*(?:class)\s*(.*?)\s*(<.*?)?\s*(#.*)?$/,
                  %r/^[ \t]*(?:def)\s*(.*?(\([^\)]*\))?)\s*(<.*?)?\s*(#.*)?$/,
                  %r/^[ \t]*(?:attr_.*?)\s*(.*?(\([^\)]*\))?)\s*(<.*?)?\s*(#.*)?$/], 
      :filter => /_string/).to_ary
    assert_kind_of Array, fred.to_ary, $debug_codecompletion.inspect
    assert fred.to_ary.length > 0, $debug_codecompletion.inspect
    
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "a", "TM_COLUMN_NUMBER" => "2", "TM_INPUT_START_COLUMN" => "1"})
    assert_not_nil TextmateCodeCompletion.new(fred).to_snippet
  end
  
  def test_parser_array_with_empty_rows
    fred = TextmateCompletionsParser.new('codecompletion.rb', :scope => :ruby).to_ary
    assert fred.to_ary.grep(/^$/).length == 0, fred.to_ary.grep(/^$/).inspect
  end
end

def set_tm_vars(env)
  ENV['TM_BUNDLE_PATH']        = env['TM_BUNDLE_PATH'] if env['TM_BUNDLE_PATH']
  # ENV['TM_SUPPORT_PATH']       = env['TM_SUPPORT_PATH']
  ENV['TM_COLUMN_NUMBER']      = env['TM_COLUMN_NUMBER']
  ENV['TM_CURRENT_LINE']       = env['TM_CURRENT_LINE']
  ENV['TM_INPUT_START_COLUMN'] = env['TM_INPUT_START_COLUMN']
  ENV['TM_SELECTED_TEXT']      = env['TM_SELECTED_TEXT']
end
