bundle				= ENV['TM_BUNDLE_PATH']

require (bundle + "/bin/Builder.rb")

mup = Builder::XmlMarkup.new(:target => STDOUT)

class << mup
	
	attr_accessor :current_class
	attr_accessor :div_count
	
	# accumulative div
	def new_div!( nclass, content = "" )
		is_new = false
		
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
				a( "Show", 'href' => "javascript:showElement('#{div_id + "_c"}')")
				a( "Hide", 'href' => "javascript:hideElement('#{div_id + "_c"}')")
			}

			_start_tag( "div", "class" => "inner", "id" => div_id + "_c" )
			
			is_new = true
		end
		text! content
		is_new
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
		new_div!( "normal", string )
		br
	end
		
end


SCRIPT = <<ENDSCRIPT
function showElement( div_id )
{
//	document.writeln(div_id)
	document.getElementById( div_id ).style.display = 'block';
}

function hideElement( div_id )
{
//	document.writeln(div_id)
	document.getElementById( div_id ).style.display = 'none';
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
	font-size: 70%;

	color: black;
}

div.normal {
	border-style: solid none solid none;
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
			error_match = /^(.+?):(\d+):(?:.*?:)?\s*(.*)/.match(line)
			
			unless error_match.nil?
				
				path		= error_match[1]
				line_number	= error_match[2]
				
				# if the file doesn't exist, we probably snagged something that's not an error
				if File.exist?(path)

					# parse for "error", "warning", and "info" and use appropriate CSS classes					
					cssclass = /^\s*(error|warning|info|message|(?:syntax error))/i.match(error_match[3])
					
					cssclass = cssclass[0].downcase unless cssclass.nil?
					cssclass = case cssclass
						when nil
							cssclass = "info"
						when "message"
							"info"
						when "syntax error"
							"error"
						else
							cssclass
					end
										
					if mup.new_div!(cssclass) then String
						mup.h2(cssclass)
					end
					mup.p {
						mup.a( "href" => "txmt://open?url=file://#{path}&line=#{line_number}" ) {
							mup.text!( File.basename(path) + ":" + line_number + ": " + error_match[3] )
						}
					}
					next													# =======> next
				end
			else
				
				# highlight each target name
				if /^===.*===$/.match(line) then
					mup.end_div!
					mup.h2(line, "class" => "targetname")
					next													# =======> next
				end
			end
			
			mup.normal!( line )
		end
		
		# play sound on success/failure
		success = /\*\* BUILD SUCCEEDED \*\*/.match(last_line)
		success = success.nil? ? false : true
		
		sound = if success then
			mup.new_div!("info")
			mup.h2("Build Succeeded")
			'Harp.wav'
		else
			mup.new_div!("error")
			mup.h2("Build Failed")
			'Whistle.wav'
		end
		mup.text!(last_line)

		%x{cd "#{bundle}"; bin/play Sounds/#{sound} &}
		
		# wrap up any loose ends
		mup.end_div!
	}
}


