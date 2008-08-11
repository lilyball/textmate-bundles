#!/usr/bin/env ruby
require ENV['TM_SUPPORT_PATH'] + '/lib/current_word'
require ENV['TM_SUPPORT_PATH'] + '/lib/ui'

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
      return TextMate::UI.tool_tip('Nothing to Complete') unless choices
      TextMate::UI.complete(choices, {:images => images, :chars => chars, :extra_chars => extra_chars})
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
      ENV['TM_COMPLETIONS_EXTRACHARS']
    end
    
    def chars
      ENV['TM_COMPLETIONS_CHARS']
    end
    
    private
    def data(raw_data=ENV['TM_COMPLETIONS'])
      return {} unless raw_data and not raw_data.empty?
      
      return @data = OSX::PropertyList.load(raw_data) if \
        ENV['TM_COMPLETIONS_SPLIT'] == 'plist'
      
      ENV['TM_COMPLETIONS_SPLIT'] ||= ','
      
      @data = {}
      @data['suggestions'] = array_to_suggestions(ENV['TM_COMPLETIONS'].split(ENV['TM_COMPLETIONS_SPLIT']))
      
      return @data
    end
    
    def array_to_suggestions(suggestions)
      suggestions.map { |c| {'display' => c} }
    end
    
  end
end

if __FILE__ == $0
`open "txmt://open?url=file://$TM_FILEPATH"` #For testing purposes, make this document the topmost so that the complete popup works
ENV['WEB_PREVIEW_RUBY']='NO-RUN'

require "test/unit"
# require "complete"
class TestComplete < Test::Unit::TestCase
  def test_basic_complete
    ENV['TM_COMPLETIONS'] = 'ad(),adipisicing,aliqua,aliquip,amet,anim,aute,cillum,commodo,consectetur,consequat,culpa,cupidatat,deserunt,do,dolor,dolore,Duis,ea,eiusmod,elit,enim,esse,est,et,eu,ex,Excepteur,exercitation,fugiat,id,in,incididunt,ipsum,irure,labore,laboris,laborum,Lorem,magna,minim,mollit,nisi,non,nostrud,nulla,occaecat,officia,pariatur,proident,qui,quis,reprehenderit,sed,sint,sit,sunt,tempor,ullamco,Ut,ut,velit,veniam,voluptate,'
    
    assert_equal ENV['TM_COMPLETIONS'].split(','), TextMate::Complete.new.choices.map{|c| c['display']}
    assert_equal TextMate::Complete::IMAGES, TextMate::Complete.new.images
    
    TextMate::Complete.new.complete!
    # 
  end
  def test_should_support_plist
    ENV['TM_COMPLETIONS_SPLIT']='plist'
    ENV['TM_COMPLETIONS'] = <<-'PLIST'
    { suggestions = ( 
        { display = moo; image = Drag;    insert = "(${1:one}, ${2:one}, ${3:three}${4:, ${5:five}, ${6:six}})";         tool_tip = "moo(one, two, four[, five])\n This method does something or other maybe.\n Insert longer description of it here."; }, 
        { display = foo; image = Macro;   insert = "(${1:one}, \"${2:one}\", ${3:three}${4:, ${5:five}, ${6:six}})";     tool_tip = "foo(one, two)\n This method does something or other maybe.\n Insert longer description of it here."; }, 
        { display = bar; image = Command; insert = "(${1:one}, ${2:one}, \"${3:three}\"${4:, \"${5:five}\", ${6:six}})"; tool_tip = "bar(one, two[, three])\n This method does something or other maybe.\n Insert longer description of it here."; } 
      ); 
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
    TextMate::Complete.new.complete!
    # 
  end
  def test_should_be_able_to_modify_the_choices
    ENV['TM_COMPLETIONS'] = 'ad(),adipisicing,aliqua,aliquip,amet,anim,aute,cillum,commodo,consectetur,consequat,culpa,cupidatat,deserunt,do,dolor,dolore,Duis,ea,eiusmod,elit,enim,esse,est,et,eu,ex,Excepteur,exercitation,fugiat,id,in,incididunt,ipsum,irure,labore,laboris,laborum,Lorem,magna,minim,mollit,nisi,non,nostrud,nulla,occaecat,officia,pariatur,proident,qui,quis,reprehenderit,sed,sint,sit,sunt,tempor,ullamco,Ut,ut,velit,veniam,voluptate,'
    
    fred = TextMate::Complete.new
    
    assert_equal ENV['TM_COMPLETIONS'].split(','), fred.choices.map{|c| c['display']}
    fred.choices.reject!{|choice| choice['display'] !~ /^a/ }
    assert_equal ENV['TM_COMPLETIONS'].split(',').grep(/^a/), fred.choices.map{|c| c['display']}
    
    fred.choices=%w[fred is not my name]
    assert_equal %w[fred is not my name], fred.choices.map{|c| c['display']}
    
    # 
  end
end

end#if
