bundle				= ENV['TM_BUNDLE_PATH']

require (bundle + "/bin/Builder.rb")

mup = Builder::XmlMarkup.new(:target => STDOUT)

# N.B. This code is not a model of Ruby clarity.
# I'm still experimenting with Builder.rb.
#
# TODO This really ought to be factored into two parts:
# (1) a parsing layer and (2) a separate presentation layer
# that would be called from the parser.

class << mup
	
	attr_accessor :current_class
	attr_accessor :div_count
	attr_accessor :next_div_name
	attr_accessor :accumulated_prefix
	
	
	def a_textmate!( path, line_number )
		line_number = 1 if line_number.nil?
		a( "href" => "txmt://open?url=file://#{path}&line=#{line_number}" ) {
			text!( File.basename(path) + ":" + line_number.to_s )
		}
	end
	
	# accumulate content that will prefix the next div
	def accumulate!(content)
		@accumulated_prefix = '' unless defined?(@accumulated_prefix)
		@accumulated_prefix << content
	end
	
	# accumulative div -- block yields the div title
	def new_div!( nclass, content = "", hide = false, &block )
		div_id = nil
		
		@div_count = 0 unless defined?(@div_count)
		@accumulated_prefix = '' unless defined?(@accumulated_prefix)
		
		unless nclass === @current_class
			@div_count += 1
			div_id = "xyz_" + @div_count.to_s
			
			# end the old div
			end_div!
			
			# start the new div and the inner content div
			@current_class = nclass
			_start_tag( "div", "class" => nclass, "id" => div_id )

			hide_if_hidden_style = hide ? "display: none;" : "";
			show_if_hidden_style = hide ? "" : "display: none;";

			# add show/hide toggle above the inner content div
			div( "class" => "showhide" ) {
								
				a( "Hide Details", 'href' => "javascript:hideElement('#{div_id}')", 'id' => div_id + '_hide', 'style' => hide_if_hidden_style )
				a( "Show Details", 'href' => "javascript:showElement('#{div_id}')", 'id' => div_id + '_show', 'style' => show_if_hidden_style )
			}
			
			block.call

			# show the user at least the title of the div
			STDOUT.flush
			
			_start_tag( "div", "class" => "inner", "id" => div_id + "_c", 'style' => hide_if_hidden_style )
			
		end
		
		# output the div prefix for error/message boxes
		unless @accumulated_prefix.empty? || @current_class == 'normal'
			
			@accumulated_prefix.each_line do |prefixline|
				
				# process any file paths
				match = /(\/.+?):(\d+)?/.match(prefixline)
				
				if match.nil? then
					text!( prefixline )
				else
					first = match.begin(1)
					last = match.end(2)
					last = match.end(1) if last.nil?
					
					text!(prefixline[0...(first)])
					
					a_textmate!( match[1], match[2] )
					
					text!(prefixline[last...(prefixline.length - 1)])
				end
				br
			end
			
			@accumulated_prefix = ''
		end
		
		text! content
		
		div_id
	end

	# wrap up any loose ends
	def end_div!
		if defined?( @current_class ) then
			_end_tag("div")	# inner
			_end_tag("div") # outer
			@current_class = nil
		end
	end

	def normal!(string)
		
		return if string.empty?
		return if string === "\n"
		
		new_div!( "normal", string, false ) do
			
			if @next_div_name.nil?
				title = "..."
			else
				title = @next_div_name
				@next_div_name = nil
			end
			h2(title)
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
	font-size: 8pt;
	font-family: sans-serif;
	margin-top: 2px;
	margin-bottom: 2px;
}

div.normal {
	padding: 2px;
	margin: 3px;

	border: 2px;
	border-style: none none none solid;
	color: #aaa;
	font-size: 70%;
	margin 0;
}

div.normal h2 {
	font-size: 10pt;
	margin-top: 2px;
	margin-bottom: 2px;
}

h1 {
   font-size: 14pt;
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

div.error h2, div.warning h2, div.info h2 {
/*   font-size: 10pt;*/
   font-family: sans-serif;
   margin-top: 0;
}

div.inner :link {
	font-family: "Bitstream Vera Sans Mono", monospace;
}

div.error, div.warning, div.info {
	padding: 4px;
	margin: 3px;
	font-size: 7pt;
}

div.error {
   color: #f30;
   background-color: #fee;
   border: 2px solid #f52;
}

div.warning {
   color: #CDC335;
   background-color: #FFD;
   border: 2px solid #CDC335;
}

div.info {
   color: #03f;
   background-color: #eef;
   border: 2px solid #25f;
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
		mup.h1("Building With Xcode")
		mup.hr
		STDOUT.flush

		STDIN.each_line do |line|
			
			# remember the current line for later
			last_line = line
			
			case line

# TODO: xcodebuild generates lines like:
# CompileC "file.o" Source/file.cpp normal ppc c++ com.apple.compilers.gcc.3_3 
# We could parse these to provide build status delimited by file.
# Then we might consider hiding the build details by default.

				
				# Handle error prefix text
				when /^\s*((In file included from)|from)(\s*)(\/.*?):/
					
#					if File.exist?("#$3")
						mup.accumulate!( line )
#					else
#						mup.normal!( line )
#					end

				# <path>:<line>:[column:] error description
				when /^(.+?):(\d+):(?:\d*?:)?\s*(.*)/
					path		= "#$1"
					line_number = "#$2"
					error_desc	= "#$3"
				
					# if the file doesn't exist, we probably snagged something that's not an error
					if File.exist?(path)

						# parse for "error", "warning", and "info" and use appropriate CSS classes					
						cssclass = /^\s*(error|warning|info|message)/i.match(error_desc)
					
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
							mup.a_textmate!( path, line_number )
							mup.text!(":" + error_desc)
						}
					else
						mup.normal!( line )
					end

				when /^\s*(\s*)(\/.*?):/
					
					if File.exist?("#$2")
						mup.accumulate!( line )
					else
						mup.normal!( line )
					end
									
				# highlight each target name
				when /^===(.*)===$/
					mup.end_div!
					mup.next_div_name = "#$1"
				
				else
					mup.normal!( line )
			end
			
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


