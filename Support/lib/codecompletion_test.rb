#!/usr/bin/env ruby
# 
# CodeCompletion TESTS
# 

require ENV['TM_SUPPORT_PATH'] + '/lib/codecompletion'
require 'test/unit'

puts "\nJust keep hittin' 1\n\n"

def print(text)
  return text
end

class FakeStdin < String
  def read
    self
  end
end
STDIN = FakeStdin.new ''

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
  
  def test_selection_no_line
    set_tm_vars({"TM_SELECTED_TEXT" => "basic_selection", "TM_CURRENT_LINE" => "basic_selection", "TM_COLUMN_NUMBER" => "1", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal "test_selection$0", TextmateCodeCompletion.new(['test_selection'], %{basic_selection}).to_snippet, $debug_codecompletion.inspect
  end
  
  def test_snippetize
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "String", "TM_COLUMN_NUMBER" => "7", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal "String.method(${1:})$0", TextmateCodeCompletion.new(['String.method()'], %{String}).to_snippet, $debug_codecompletion.inspect
  end
  
  def test_snippetize_methods
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "String", "TM_COLUMN_NUMBER" => "7", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal %{String.method(${1:"${2:one}"},${3:two})(${4:})$0}, TextmateCodeCompletion.new(['String.method("one",two)()'], %{String}).to_snippet, $debug_codecompletion.inspect
  end
  def test_snippetize_methods_with_stuff
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "change_column", "TM_COLUMN_NUMBER" => "14", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal 'change_column(${1:table_name},${2: column_name},${3: type},${4: options = {\}})$0', TextmateCodeCompletion.new([%{change_column(table_name, column_name, type, options = {})}],'').to_snippet, $debug_codecompletion.inspect
  end
  def test_snippetize_bracket_escaping
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "{before} {inside} {after}", "TM_COLUMN_NUMBER" => "14","TM_INPUT_START_COLUMN" => "1"})
    assert_equal %{{before} {ins${0:}ide} {after}}, TextmateCodeCompletion.new(['test'], %{{before} {inside} {after}}).to_snippet, $debug_codecompletion.inspect
  end
  def test_snippetize_quotes
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "String", "TM_COLUMN_NUMBER" => "7", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal %{String="${1:some '${2:thing}'}"$0}, TextmateCodeCompletion.new([%{String="some 'thing'"}], %{String}).to_snippet, $debug_codecompletion.inspect
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
    tcc = TextmateCodeCompletion.new(['.aaa'], %{.}, {:characters => /[-_:#\.\w]$/})
    assert_equal ".aaa$0", tcc.to_snippet  , $debug_codecompletion.inspect
    assert_equal 0, tcc.index              , $debug_codecompletion.inspect
    assert_equal '.aaa', tcc.choice        , $debug_codecompletion.inspect
  end
  
  def test_sort
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "basic", "TM_COLUMN_NUMBER" => "6", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal "basic$0", TextmateCodeCompletion.new(
      %w[basic2 basic3 basic basic1], 
      %{basic},
      {:sort => true}
    ).to_snippet
  end
  
  def test_html
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "<div><p><a><img ></a></p></div>", "TM_COLUMN_NUMBER" => "17", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal %{<div><p><a><img one="${1:}"$0></a></p></div>}, TextmateCodeCompletion.new(
      ['<img one=""','<img two=""','<div three=""','<div four=""'], 
      %{<div><p><a><img ></a></p></div>}, 
      {:scope => :html_attributes}
    ).to_snippet, $debug_codecompletion.inspect
  end
  def test_context_sensitive_filter
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => %{<div><p><a><img class="Value" t></a></p></div>}, "TM_COLUMN_NUMBER" => "32", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal %{<div><p><a><img class="Value" talc="${1:}"$0></a></p></div>}, TextmateCodeCompletion.new(
      ['class=""','turtles=""','talc=""','id=""','zero=""','nada=""','<img one=""','<img two=""','<div three=""','<div four=""'], 
      %{<div><p><a><img class="Value" t></a></p></div>}, 
      {:scope => :html_attributes}
    ).to_snippet, $debug_codecompletion.inspect
  end
  def test_html_with_other_attributes
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "<div><p><a><img class=\"Value\" ></a></p></div>", "TM_COLUMN_NUMBER" => "31", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal %{<div><p><a><img class="Value" class="${1:}"$0></a></p></div>}, TextmateCodeCompletion.new(
      ['<img id=""','<div id=""','<div class=""','<img class=""',], 
      %{<div><p><a><img class="Value" ></a></p></div>}, 
      {:scope => :html_attributes}
    ).to_snippet, $debug_codecompletion.inspect
  end
  def test_html_with_embedded_source
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => %{<div><p><a><img class="<%= something %>" ></a></p></div>}, "TM_COLUMN_NUMBER" => "42", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal %{<div><p><a><img class="<%= something %>" class="${1:}"$0></a></p></div>}, TextmateCodeCompletion.new(
      ['<img id=""','<div id=""','<div class=""','<img class=""',], 
      %{<div><p><a><img class="<%= something %>" ></a></p></div>}, 
      {:scope => :html_attributes}
    ).to_snippet, $debug_codecompletion.inspect
  end
  
  def test_padding
    # Insert the padding character if it's not there already
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "<img.>", "TM_COLUMN_NUMBER" => "6", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal %{<img. test$0>}, TextmateCodeCompletion.new(['test'], %{<img.>}, :padding => ' ').to_snippet, $debug_codecompletion.inspect
  end
  def test_no_padding
    # Don't insert the padding text if it's already there
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "<img >", "TM_COLUMN_NUMBER" => "6", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal %{<img test$0>}, TextmateCodeCompletion.new(['test'], %{<img >}, :scope => :html_attributes).to_snippet, $debug_codecompletion.inspect
  end
    
  def test_nil_line_before
    # Do insert if there's no line_before text
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => ">", "TM_COLUMN_NUMBER" => "1", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal %{test$0>}, TextmateCodeCompletion.new(['test'], %{>}).to_snippet, $debug_codecompletion.inspect
    
    # Don't insert anything if there's no line_before text and :nil_context===false
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => ">", "TM_COLUMN_NUMBER" => "1", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal %{${0:}>}, TextmateCodeCompletion.new(['test'], %{>}, :scope => :html_attributes).to_snippet, $debug_codecompletion.inspect
    
    # Don't insert anything if the line_before text doesn't match the :context and :nil_context===false
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "  <>", "TM_COLUMN_NUMBER" => "3", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal %{  ${0:}<>}, TextmateCodeCompletion.new(['test'], %{  <>}, :scope => :html_attributes).to_snippet, $debug_codecompletion.inspect
    
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "<>", "TM_COLUMN_NUMBER" => "3", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal %{<>${0:}}, TextmateCodeCompletion.new(['test'], %{<>}, :scope => :html_attributes).to_snippet, $debug_codecompletion.inspect
  end
  
  def test_caret_placement
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "\t\t</div>", "TM_COLUMN_NUMBER" => "1", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal %{test$0		</div>}, TextmateCodeCompletion.new(['test'], %{		</div>}).to_snippet, $debug_codecompletion.inspect
  end
  
  def test_html_with_no_attributes
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "<div>", "TM_COLUMN_NUMBER" => "5", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal %{<div class="${1:}"$0>}, TextmateCodeCompletion.new(['<div class=""'], %{<div>}, :scope => :html_attributes).to_snippet, $debug_codecompletion.inspect
  end
  
  def test_go_basic
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "basic", "TM_COLUMN_NUMBER" => "6", "TM_INPUT_START_COLUMN" => "1"})
    ENV['TM_COMPLETIONS'] = 'basic,basic1'
    
    text = TextmateCodeCompletion.go!
    assert_equal "basic$0", text
  end
  
  def test_go_vars
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "basic", "TM_COLUMN_NUMBER" => "6", "TM_INPUT_START_COLUMN" => "1"})
    ENV['TM_COMPLETIONS'] = 'basicbasic1'
    ENV['TM_COMPLETION_split'] = ''
    
    text = TextmateCodeCompletion.go!
    assert_equal "basic$0", text
  end
  
  def test_shouldnt_have_to_escape_dollars
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "", "TM_COLUMN_NUMBER" => "1", "TM_INPUT_START_COLUMN" => "1"})
    assert_equal %q{\$\$(${1:'${2:selectors:mixed}'})\$\$$0}, TextmateCodeCompletion.new(["$$('selectors:mixed')$$"]).to_snippet
    assert_equal %q{\$apple\$$0}, TextmateCodeCompletion.new(["$apple$"]).to_snippet
  end
  
  def test_plist_split
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "basic", "TM_COLUMN_NUMBER" => "6", "TM_INPUT_START_COLUMN" => "1"})
    ENV['TM_COMPLETIONS'] = %{{ suggestions =(
          { title = "basic"; },
          { title = "basic1"; },
          { title = "basic2"; }
        );}}
    ENV['TM_COMPLETION_split'] = 'plist'
    
    text = TextmateCodeCompletion.go!
    assert_equal "basic$0", text
  end
  
  def test_plist_snippet
    set_tm_vars({"TM_SELECTED_TEXT" => nil, "TM_CURRENT_LINE" => "basic", "TM_COLUMN_NUMBER" => "6", "TM_INPUT_START_COLUMN" => "1"})
    ENV['TM_COMPLETIONS'] = %{{ suggestions =( { title = "basic 'All this text should be removed'"; snippet = "basic"; } );}}
    ENV['TM_COMPLETION_split'] = 'plist'
    
    text = TextmateCodeCompletion.go!
    # assert_equal "basic$0", text
    # Haven't implemented the code to make this pass yet :-!
  end
end

class TextmateCompletionsPlistTest < Test::Unit::TestCase

  def test_plist_file
    `echo "{settings={ completions = ( 'fibbity', 'flabbity', 'floo' ); };}" >/tmp/test_plist_file.plist`
    completions = TextmateCompletionsPlist.new("/tmp/test_plist_file.plist")
    assert_not_nil completions
    assert_kind_of Array, completions.to_ary
    assert completions.to_ary.length > 0
  end
  
  def test_plist_string_format1
    completions = TextmateCompletionsPlist.new("{ completions = ( 'fibbity', 'flabbity', 'floo' ); }")
    assert_not_nil completions
    assert_kind_of Array, completions.to_ary
    assert completions.to_ary.length == 3, completions.choices
  end
  
  def test_plist_string_format2
    completions = TextmateCompletionsPlist.new %{{ suggestions =( { title = "basic"; }, { title = "basic1"; }, { title = "basic2"; } );}}
    assert_not_nil completions
    assert_kind_of Array, completions.to_ary
    assert completions.to_ary.length == 3, completions.choices
  end
  
  def test_plist_both_formats
    completions = TextmateCompletionsPlist.new %{{
      completions = ( 'fibbity', 'flabbity', 'floo' );
      suggestions = ( { title = "basic"; }, { title = "basic1"; }, { title = "basic2"; } );
    }}
    assert ['basic', 'basic1', 'basic2'] == completions.to_ary
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
