#!/usr/bin/env ruby -wKU

SUPPORT = ENV['TM_SUPPORT_PATH']
DIALOG = SUPPORT + '/bin/tm_dialog'
ANT_COMPS = ENV['TM_BUNDLE_PATH']+"/support/data/ant_completions.xml"

require "rexml/document"
require SUPPORT + '/lib/escape'
require SUPPORT + '/lib/exit_codes'
require SUPPORT + '/lib/osx/plist'

#Search for
word = STDIN.read.strip
TextMate.exit_show_tool_tip("Please select a term to complete.") if word.empty?

search_results = [];
ant_doc = REXML::Document.new File.new(ANT_COMPS)
ant_doc.elements.each( "completion_list/*" ) do |tag|

    n = tag.local_name
    
    if n[/^#{word}/i]
        
        snip_num = 1;
        tag.attributes.each do |name, value| 
            tag.attributes[name] = '${' + snip_num.to_s + ':' + value + '}'
            snip_num = snip_num + 1
        end
        
        unless tag.text == nil
            if tag.text == " "
                tag.text = "$0"
            else
                tag.text = '${' + snip_num.to_s + ':' + tag.text + '}'
            end
        end
        
        search_results.push( { 'title' => n , 'data' => tag.to_s.gsub( "'", '"' ) }  )
        
    end
    
end

TextMate.exit_show_tool_tip( "No completion found." ) if search_results.empty?

if search_results.size > 1
    
	plist = { 'menuItems' => search_results }.to_plist	
	res = OSX::PropertyList::load( `#{e_sh DIALOG} -up #{e_sh plist}` )

	TextMate.exit_discard() unless res.has_key? 'selectedMenuItem'
	choice = res['selectedMenuItem']['data']

else

	choice = search_results.pop['data']

end

print choice