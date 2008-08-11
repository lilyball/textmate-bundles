#!/usr/bin/env ruby
require ENV['TM_SUPPORT_PATH'] + '/lib/current_word'
require ENV['TM_SUPPORT_PATH'] + '/lib/ui'

module TextMate
	module Complete
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
		
		class << self
			
			# 0-config completion command using environment variables for everything
			def complete!
				return TextMate::UI.tool_tip('Nothing to Complete') unless choices
				TextMate::UI.complete(choices, {:images => images})
			end
			
			def choices
				data['suggestions']
			end
			
			def images
				data['images'] ||= IMAGES
			end
			
			private
			def data
				return @data if @data
				return @data = OSX::PropertyList.load(ENV['TM_COMPLETIONS']) if \
					ENV['TM_COMPLETIONS_split'] == 'plist'
				
				ENV['TM_COMPLETIONS_split'] ||= ','
				
				@data = {}
				@data['suggestions'] = ENV['TM_COMPLETIONS']\
					.split(ENV['TM_COMPLETIONS_split'])\
					.map { |c| {'display' => c} }
				
				return @data
			end
		end
	end
end

if __FILE__ == $0
`open "txmt://open?url=file://$TM_FILEPATH"` #For testing purposes, make this document the topmost so that the complete popup works

require "test/unit"
# require "complete"
class TestComplete < Test::Unit::TestCase
	def test_basic_complete
		ENV['TM_COMPLETIONS'] = 'ad(),adipisicing,aliqua,aliquip,amet,anim,aute,cillum,commodo,consectetur,consequat,culpa,cupidatat,deserunt,do,dolor,dolore,Duis,ea,eiusmod,elit,enim,esse,est,et,eu,ex,Excepteur,exercitation,fugiat,id,in,incididunt,ipsum,irure,labore,laboris,laborum,Lorem,magna,minim,mollit,nisi,non,nostrud,nulla,occaecat,officia,pariatur,proident,qui,quis,reprehenderit,sed,sint,sit,sunt,tempor,ullamco,Ut,ut,velit,veniam,voluptate,'
		TextMate::Complete.complete!
		# 
	end
	def test_should_support_plist
		ENV['TM_COMPLETIONS_split']='plist'
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
		TextMate::Complete.complete!
		# 
	end
end

end#if
