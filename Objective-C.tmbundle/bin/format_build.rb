bundle				= ENV['TM_BUNDLE_PATH']

require (bundle + "/bin/Builder.rb")

mup = Builder::XmlMarkup.new(:target => STDOUT)

class << mup
	
	attr_accessor :current_class
	
	# accumulative div
	def new_div!( content, nclass)
		is_new = false
		unless nclass === @current_class
			_end_tag("div") if defined?( @current_class )
			@current_class = nclass
			_start_tag( "div", "class" => nclass )
			is_new = true
		end
		text! content
		is_new
	end

	def dude!(string)
		new_div!( string, "normal" )
		br
	end
		
end


STYLE = <<ENDSTYLE
/* general stuff.. */
body {
   font-family: sans-serif;
   font-size: 11pt;
}

div.normal {
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

/* for error formating */
div.error {
   color: #f30;
   background-color: #fee;
   border: 2px solid #f52;
   padding: 4px;
   margin: 3px;
   font-family: "Bitstream Vera Sans Mono", monospace;
   font-size: 9pt;
}

div.error h2 {
   font-size: 11pt;
   font-family: sans-serif;
   margin-top: 0;
}

div.warning {
   color: #03f;
   background-color: #eef;
   border: 1px solid #25f;
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
   border: 1px solid #25f;
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


mup.html {
	mup.head {
			mup.title("Build With Xcode")
			mup.style( STYLE, "type" => "text/css")
	}

	mup.body { 
		mup.h1("Building '#{File.basename(ENV['TM_FILEPATH'])}'")
		mup.hr
		STDOUT.flush

		STDIN.each_line do |line|
			
			# /path/to/file:123:error description
			error_match = /^(.+?):(\d+):\s*(.*)/.match(line)
			
			unless error_match.nil?
				
				path		= error_match[1]
				line_number	= error_match[2]
				
				# if the file doesn't exist, we probably snagged something that's not an error
				if File.exist?(path)
					# TODO parse for "error", "warning", and "info" and use appropriate CSS classes
					if mup.new_div!("", "error") then
						mup.h2("Error")
					end
					mup.p {
						mup.a( "href" => "txmt://open?url=file://#{path}&line=#{line_number}" ) {
							mup.text!( File.basename(path) + ":" + line_number + ": " + error_match[3] )
						}
					}
					next	# =======> next
				end
			else
				
				# highlight each target name
				if /^===.*===$/.match(line) then
					mup.h2(line, "class" => "targetname")
					next	# =======> next
				end
			end
			
			mup.dude!( line )
		end
	}
}

# TODO play sound on success/failure


