#!/usr/bin/env ruby
require ENV['TM_SUPPORT_PATH'] + '/lib/current_word'
require ENV['TM_SUPPORT_PATH'] + '/lib/ui'
require ENV['TM_SUPPORT_PATH'] + '/lib/escape'
require ENV['TM_SUPPORT_PATH'] + '/lib/osx/plist'
require 'rubygems'
require 'json'

module TextMate
  class Complete
    IMAGES = {
      "C"   => "/Applications/TextMate.app/Contents/Resources/Bundle Item Icons/Commands.png",
      "D"   => "/Applications/TextMate.app/Contents/Resources/Bundle Item Icons/Drag Commands.png",
      "L"   => "/Applications/TextMate.app/Contents/Resources/Bundle Item Icons/Languages.png",
      "M"   => "/Applications/TextMate.app/Contents/Resources/Bundle Item Icons/Macros.png",
      "P"   => "/Applications/TextMate.app/Contents/Resources/Bundle Item Icons/Preferences.png",
      "S"   => "/Applications/TextMate.app/Contents/Resources/Bundle Item Icons/Snippets.png",
      "T"   => "/Applications/TextMate.app/Contents/Resources/Bundle Item Icons/Templates.png",
      "Doc" => "/Applications/TextMate.app/Contents/Resources/Bundle Item Icons/Template Files.png",
    }
    
    def initialize
    end
    
    # 0-config completion command using environment variables for everything
    def complete!
      return choices unless choices
      TextMate::UI.complete(choices, {:images => images, :extra_chars => extra_chars})
    end
    
    def choices
      @choices ||= data['suggestions']
    end
    def choices= choice_array
      @choices = array_to_suggestions(choice_array)
    end
    
    def images
      data['images'] ||= IMAGES
    end
    
    def extra_chars
      ENV['TM_COMPLETIONS_EXTRACHARS'] || data['extra_chars']
    end
    
    def chars
      "a-zA-Z0-9"
    end
    
    private
    def data(raw_data=nil)
      fix_legacy
      
      raw_data ||= read_data
      return {} unless raw_data and not raw_data.empty?
      
      @data = parse_data raw_data
      return @data
    end
    
    def read_data
      raw_data = read_file
      raw_data ||= read_string
      raw_data
    end
    def read_file
      # Expand Completion File Path
      if ENV['TM_COMPLETIONS_FILE'] and not File.exists? ENV['TM_COMPLETIONS_FILE']
        ENV['TM_COMPLETIONS_FILE'] = ENV['TM_BUNDLE_SUPPORT'] + '/' + ENV['TM_COMPLETIONS_FILE']
      end
      
      return nil unless ENV['TM_COMPLETIONS_FILE'] and File.exists? ENV['TM_COMPLETIONS_FILE']
      self.raw_format = ENV['TM_COMPLETIONS_FILE'].scan(/\.([^\.]+)$/).last.last
      
      File.read(ENV['TM_COMPLETIONS_FILE'])
    end
    def read_string
      self.raw_format = ENV['TM_COMPLETIONS_SPLIT']
      ENV['TM_COMPLETIONS']
    end
    
    attr_accessor :raw_format
    
    def parse_data(raw_data)
      case raw_format
      when 'plist'
        parse_plist raw_data
      when 'json'
        parse_json raw_data
      when "txt"
        self.raw_format = "\n"
        parse_string raw_data
      when nil
        self.raw_format = ","
        parse_string raw_data
      else
        parse_string raw_data
      end
    end
    def parse_string(raw_data)
      return {} unless raw_data
      return raw_data unless raw_data.respond_to? :to_str
      raw_data = raw_data.to_str
      
      data = {}
      data['suggestions'] = array_to_suggestions(raw_data.split(raw_format))
      data
    end
    def parse_plist(raw_data)
      OSX::PropertyList.load(raw_data)
    end
    def parse_json(raw_data)
      JSON.parse(raw_data)
    end
    
    def array_to_suggestions(suggestions)
      suggestions.delete('')
      
      suggestions.map! do |c|
        {'display' => c}
      end
      
      suggestions
    end
    
    def fix_legacy
      ENV['TM_COMPLETIONS_SPLIT'] ||= ENV['TM_COMPLETIONS_split'] 
    end
  end
end

if __FILE__ == $0

`open "txmt://open?url=file://$TM_FILEPATH"` #For testing purposes, make this document the topmost so that the complete popup works
ENV['WEB_PREVIEW_RUBY']='NO-RUN'
require "test/unit"
# require "complete"

class TestComplete < Test::Unit::TestCase
  def setup
    @string_raw = 'ad(),adipisicing,aliqua,aliquip,amet,anim,aute,cillum,commodo,consectetur,consequat,culpa,cupidatat,deserunt,do,dolor,dolore,Duis,ea,eiusmod,elit,enim,esse,est,et,eu,ex,Excepteur,exercitation,fugiat,id,in,incididunt,ipsum,irure,labore,laboris,laborum,Lorem,magna,minim,mollit,nisi,non,nostrud,nulla,occaecat,officia,pariatur,proident,qui,quis,reprehenderit,sed,sint,sit,sunt,tempor,ullamco,Ut,ut,velit,veniam,voluptate,'
    
    @plist_raw = <<-'PLIST'
    { suggestions = ( 
        { display = moo; image = Drag;    insert = "(${1:one}, ${2:one}, ${3:three}${4:, ${5:five}, ${6:six}})";         tool_tip = "moo(one, two, four[, five])\n This method does something or other maybe.\n Insert longer description of it here."; }, 
        { display = foo; image = Macro;   insert = "(${1:one}, \"${2:one}\", ${3:three}${4:, ${5:five}, ${6:six}})";     tool_tip = "foo(one, two)\n This method does something or other maybe.\n Insert longer description of it here."; }, 
        { display = bar; image = Command; insert = "(${1:one}, ${2:one}, \"${3:three}\"${4:, \"${5:five}\", ${6:six}})"; tool_tip = "bar(one, two[, three])\n This method does something or other maybe.\n Insert longer description of it here."; } 
      ); 
      extra_chars = '.';
      images = { 
        Command    = "/Applications/TextMate.app/Contents/Resources/Bundle Item Icons/Commands.png"; 
        Drag       = "/Applications/TextMate.app/Contents/Resources/Bundle Item Icons/Drag Commands.png"; 
        Language   = "/Applications/TextMate.app/Contents/Resources/Bundle Item Icons/Languages.png"; 
        Macro      = "/Applications/TextMate.app/Contents/Resources/Bundle Item Icons/Macros.png"; 
        Preference = "/Applications/TextMate.app/Contents/Resources/Bundle Item Icons/Preferences.png"; 
        Snippet    = "/Applications/TextMate.app/Contents/Resources/Bundle Item Icons/Snippets.png"; 
        Template   = "/Applications/TextMate.app/Contents/Resources/Bundle Item Icons/Template Files.png"; 
        Templates  = "/Applications/TextMate.app/Contents/Resources/Bundle Item Icons/Templates.png"; 
      }; 
    }
    PLIST
    
    @json_raw = <<-'JSON'
    {
    	"extra_chars": "-_$.",
    	"suggestions": [
    		{ "display": ".moo", "image": "", "insert": "(${1:one}, ${2:one}, ${3:three}${4:, ${5:five}, ${6:six}})",         "tool_tip": "moo(one, two, four[, five])\n This method does something or other maybe.\n Insert longer description of it here." },
    		{ "display": "foo",  "image": "", "insert": "(${1:one}, \"${2:one}\", ${3:three}${4:, ${5:five}, ${6:six}})",     "tool_tip": "foo(one, two)\n This method does something or other maybe.\n Insert longer description of it here." },
    		{ "display": "bar",  "image": "", "insert": "(${1:one}, ${2:one}, \"${3:three}\"${4:, \"${5:five}\", ${6:six}})", "tool_tip": "bar(one, two[, three])\n This method does something or other maybe.\n Insert longer description of it here." }
    	],
    	"images": {
    		"String"  : "String.png",
    		"RegExp"  : "RegExp.png",
    		"Number"  : "Number.png",
    		"Array"   : "Array.png",
    		"Function": "Function.png",
    		"Object"  : "Object.png",
    		"Node"    : "Node.png",
    		"NodeList": "NodeList.png"
    	}
    }
    JSON
  end
  
  def test_basic_complete
    ENV['TM_COMPLETIONS'] = @string_raw
    
    assert_equal ENV['TM_COMPLETIONS'].split(','), TextMate::Complete.new.choices.map{|c| c['display']}
    assert_equal TextMate::Complete::IMAGES, TextMate::Complete.new.images
    
    TextMate::Complete.new.complete!
  end
  # 
  def test_should_support_plist
    ENV['TM_COMPLETIONS_SPLIT']='plist'
    ENV['TM_COMPLETIONS'] = @plist_raw
    TextMate::Complete.new.complete!
  end
  # 
  def test_should_support_json
    ENV.delete 'TM_COMPLETIONS'
    assert_nil(ENV['TM_COMPLETIONS'])
    ENV.delete 'TM_COMPLETIONS_SPLIT'
    assert_nil(ENV['TM_COMPLETIONS_SPLIT'])
    
    ENV['TM_COMPLETIONS_SPLIT']='json'
    ENV['TM_COMPLETIONS'] = @json_raw
    fred = TextMate::Complete.new
    assert_equal(3, fred.choices.length)
  end
  # 
  def test_should_be_able_to_modify_the_choices
    ENV['TM_COMPLETIONS'] = @string_raw
    
    fred = TextMate::Complete.new
    
    assert_not_nil fred.choices
    assert_equal ENV['TM_COMPLETIONS'].split(','), fred.choices.map{|c| c['display']}
    fred.choices.reject!{|choice| choice['display'] !~ /^a/ }
    assert_equal ENV['TM_COMPLETIONS'].split(',').grep(/^a/), fred.choices.map{|c| c['display']}
    
    fred.choices=%w[fred is not my name]
    assert_equal %w[fred is not my name], fred.choices.map{|c| c['display']}
  end
  # 
  def test_should_parse_files_based_on_extension_plist
    ENV['TM_COMPLETIONS_FILE'] = '/tmp/completions_test.plist'
    
    File.open(ENV['TM_COMPLETIONS_FILE'],'w'){|file| file.write @plist_raw }
    assert File.exists?(ENV['TM_COMPLETIONS_FILE'])
    
    fred = TextMate::Complete.new
    assert_equal(['moo', 'foo', 'bar'], fred.choices.map{|c| c['display']})
  end
  # 
  def test_should_parse_files_based_on_extension_txt
    ENV.delete 'TM_COMPLETIONS'
    assert_nil(ENV['TM_COMPLETIONS'])
    ENV.delete 'TM_COMPLETIONS_SPLIT'
    assert_nil(ENV['TM_COMPLETIONS_SPLIT'])
    
    ENV['TM_COMPLETIONS_FILE'] = '/tmp/completions_test.txt'
    
    File.open(ENV['TM_COMPLETIONS_FILE'],'w'){|file| file.write @string_raw.gsub(',',"\n") }
    assert File.exists?(ENV['TM_COMPLETIONS_FILE'])
    
    fred = TextMate::Complete.new
    
    assert_equal(@string_raw.split(','), fred.choices.map{|c| c['display']})
  end
  # 
  def test_should_override_split_with_extension
    ENV['TM_COMPLETIONS_SPLIT'] = ','
    ENV['TM_COMPLETIONS_FILE'] = '/tmp/completions_test.plist'
    
    File.open(ENV['TM_COMPLETIONS_FILE'],'w'){|file| file.write @plist_raw }
    assert File.exists?(ENV['TM_COMPLETIONS_FILE'])
    
    fred = TextMate::Complete.new
    assert_equal(['moo', 'foo', 'bar'], fred.choices.map{|c| c['display']})
  end
  # 
  def test_should_get_extra_chars_from_var
    ENV['TM_COMPLETIONS_SPLIT']=','
    ENV['TM_COMPLETIONS'] = @string_raw
    ENV['TM_COMPLETIONS_EXTRACHARS'] = '.'
    
    fred = TextMate::Complete.new
    assert_equal('.', fred.extra_chars)
  end
  # 
  def test_should_get_extra_chars_from_plist
    ENV['TM_COMPLETIONS_SPLIT']='plist'
    ENV['TM_COMPLETIONS'] = @plist_raw
    
    assert_nil(ENV['TM_COMPLETIONS_EXTRACHARS'])
    
    fred = TextMate::Complete.new
    assert_equal('.', fred.extra_chars)
  end
  # 
end

end#if
