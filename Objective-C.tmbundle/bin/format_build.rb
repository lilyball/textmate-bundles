bundle				= ENV['TM_BUNDLE_PATH']

require (bundle + "/bin/Builder.rb")

mup = Builder::XmlMarkup.new(:target => STDOUT)

class << mup
	
	attr_accessor :current_class
	attr_accessor :div_count
	attr_accessor :next_div_name
	
	# accumulative div -- block yields the div title
	def new_div!( nclass, content = "", hide = false, &block )
		div_id = nil
		
		@div_count = 0 unless defined?(@div_count)
		
		unless nclass === @current_class
			@div_count += 1
			div_id = "xyz_" + @div_count.to_s
			
			# end the old div
			end_div!
			
			# start the new div and the inner content div
			@current_class = nclass
			_start_tag( "div", "class" => nclass, "id" => div_id )

			# add show/hide toggle above the inner content div
			div( "class" => "showhide" ) {
				
				hide_style = hide ? "display: none;" : "";
				show_style = hide ? "" : "display: none;";
				
				a( "Hide Details", 'href' => "javascript:hideElement('#{div_id}')", 'id' => div_id + '_hide', 'style' => hide_style )
				a( "Show Details", 'href' => "javascript:showElement('#{div_id}')", 'id' => div_id + '_show', 'style' => show_style )
			}
			
			block.call

			STDOUT.flush
			
			content_style = hide ? "display: none;" : "";
			_start_tag( "div", "class" => "inner", "id" => div_id + "_c", 'style' => content_style )
			
			is_new = true
		end
		text! content
		div_id
	end

	# wrap up any loose ends
	def end_div!
		if defined?( @current_class ) then
			_end_tag("div")
			_end_tag("div")
			@current_class = nil
		end
	end

	def normal!(string)
		new_div!( "normal", string, true ) do
			
			if @next_div_name.nil?
				title = "..."
			else
				title = @next_div_name
				@next_div_name = nil
			end
			h3(title)
		end
		br
	end
		
end


SCRIPT = <<ENDSCRIPT
function showElement( div_id )
{
//	document.writeln(div_id)
	document.getElementById( div_id + '_c' ).style.display = 'block';
	document.getElementById( div_id + '_hide' ).style.display = 'inline';
	document.getElementById( div_id + '_show' ).style.display = 'none';
}

function hideElement( div_id )
{
//	document.writeln(div_id)
	document.getElementById( div_id + '_c' ).style.display = 'none';
	document.getElementById( div_id + '_hide' ).style.display = 'none';
	document.getElementById( div_id + '_show' ).style.display = 'inline';
}

ENDSCRIPT

STYLE = <<ENDSTYLE
/* general stuff.. */
body {
   font-family: sans-serif;
   font-size: 11pt;
}

div.showhide {
	float: right;
#	width: 10%;
	font-size: 90%;
	margin: 10px;
	
	color: black;
}

div.normal {
	padding: 4px;
	margin: 3px;

	border-top: 2px;
	border-style: none none none solid;
	color: #aaa;
	font-size: 70%;
	margin 0;
}

h2.targetname {
	color: black;
}

h1 {
   font-size: 18pt;
   text-shadow: #ddd 2px 3px 3px;  /* ok this is just eye candy, but i love eye candy. ;) */
}

/* make horizontal rules slightly less heavy */
hr {
	color: #ccc;
	background-color: #ccc;
	height: 1px;
	border: 0px;
}

div.inner {
	color: inherit;
	background-color: inherit;
	font-family: inherit;
	font-size: inherit;
}

/* for error formating */
div.error {
   color: #f30;
   background-color: #fee;
   border: 2px solid #f52;
   padding: 4px;
   margin: 3px;
   font-family: "Bitstream Vera Sans Mono", monospace;
   font-size: 7pt;
}

div.error h2 {
   font-size: 10pt;
   font-family: sans-serif;
   margin-top: 0;
}

div.warning {
   color: #CDC335;
   background-color: #FFD;
   border: 2px solid #CDC335;
   padding: 4px;
   margin: 3px;
   font-family: "Bitstream Vera Sans Mono", monospace;
   font-size: 7pt;
}

div.warning h2 {
   font-size: 10pt;
   font-family: sans-serif;
   margin-top: 0;
}


div.info {
   color: #03f;
   background-color: #eef;
   border: 2px solid #25f;
   padding: 4px;
   margin: 3px;
   font-family: "Bitstream Vera Sans Mono", monospace;
   font-size: 7pt;
}

div.info h2 {
   font-size: 10pt;
   font-family: sans-serif;
   margin-top: 0;
}

ENDSTYLE


last_line = ""

mup.html {
	mup.head {
		mup.title("Build With Xcode")
		mup.style( STYLE, "type" => "text/css")
		mup.script( SCRIPT, "language" => "JavaScript" )
	}

	mup.body { 
		mup.h1("Building '#{File.basename(ENV['TM_FILEPATH'])}'")
		mup.hr
		STDOUT.flush

		STDIN.each_line do |line|
			
			# remember the current line for later
			last_line = line
			
			# <path>:<line>:[column:] error description
			error_match = /^(.+?):(\d+):(?:\d*?:)?\s*(.*)/.match(line)
			
			unless error_match.nil?
				
				path		= error_match[1]
				line_number	= error_match[2]
				
				# if the file doesn't exist, we probably snagged something that's not an error
				if File.exist?(path)

					# parse for "error", "warning", and "info" and use appropriate CSS classes					
					cssclass = /^\s*(error|warning|info|message)/i.match(error_match[3])
					
					cssclass = cssclass[0].downcase unless cssclass.nil?
					cssclass = case cssclass
						when nil
							"error"
						when "message"
							"info"
						else
							cssclass
					end
										
					mup.new_div!(cssclass) { mup.h2(cssclass) }
					
					mup.p {
						mup.a( "href" => "txmt://open?url=file://#{path}&line=#{line_number}" ) {
							mup.text!( File.basename(path) + ":" + line_number + ": " + error_match[3] )
						}
					}
					next													# =======> next
				end
			else
				
				# highlight each target name
				match = /^===(.*)===$/.match(line)
				unless match.nil?
					mup.end_div!
					mup.next_div_name = match[1]
					#mup.h2(line, "class" => "targetname")
					next													# =======> next
				end
			end
			
			mup.normal!( line )
		end
		
		# play sound on success/failure
		success = /\*\* BUILD SUCCEEDED \*\*/.match(last_line)
		success = success.nil? ? false : true
		
		sound = if success then
			mup.new_div!("info") { mup.h2("Build Succeeded") }
			'Harp.wav'
		else
			mup.new_div!("error") { mup.h2("Build Failed") }
			'Whistle.wav'
		end
		mup.text!(last_line)

		%x{cd "#{bundle}"; bin/play Sounds/#{sound} &}
		
		# wrap up any loose ends
		mup.end_div!
	}
}


