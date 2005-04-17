$bundle				= ENV['TM_BUNDLE_PATH']

require ($bundle + "/bin/Builder.rb")

# N.B. This code is not a model of Ruby clarity.
# I'm still experimenting with Builder.rb.


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
   font-family: "Lucida Grande", sans-serif;
   font-size: 11pt;
}

div.showhide {
	float: right;
	font-size: 8pt;
	font-family: "Lucida Grande", sans-serif;
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

div.file span.name {
	font-size: 8pt;
	margin-top: 2px;
	margin-bottom: 2px;
	color: #000;
}

div.file span.method {
	font-size: 8pt;
	margin-top: 2px;
	margin-bottom: 2px;
	color: #777;
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
   font-family: "Lucida Grande", sans-serif;
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



class Formatter

	def initialize

		@mup = Builder::XmlMarkup.new(:target => STDOUT)
		
		class << @mup
			
			attr_accessor :current_class
			attr_accessor :div_count
			attr_accessor :next_div_name
			attr_accessor :accumulated_prefix
			
			def start_tag!(tag)
				_start_tag( tag, nil )
			end
			
			def end_tag!(tag)
				_end_tag(tag)
			end
			
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
				
#				return if string.empty?
#				return if string === "\n"
				
				new_div!( "normal", string, true ) do
					
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
		
	end
	
	# beginning of stream
	def start
		@mup.start_tag!("html")
		@mup.head {
			@mup.title("Build With Xcode")
			@mup.style( STYLE, "type" => "text/css")
			@mup.script( SCRIPT, "language" => "JavaScript" )
		}
		@mup.start_tag!("body")

		@mup.h1("Building With Xcode")
		@mup.hr
		STDOUT.flush
	end
		
	# end of stream
	def complete
		# wrap up any loose ends
		@mup.end_div!

		@mup.end_tag!("body")
		@mup.end_tag!("html")
	end
	
	# error messages
	# cssclass may be nil
	def error_message( cssclass, path, line, error_desc )
		
		cssclass = cssclass.downcase
		cssclass = case cssclass
			when ""
				"error"
			when "message"
				"info"
			else
				cssclass
		end

		@mup.new_div!(cssclass) { @mup.h2(cssclass) }
	
		@mup.p {
			@mup.a_textmate!( path, line )
			@mup.text!(":" + error_desc)
		}

	end

	def file_compiled( method, file )
		@mup.end_div!
#		@mup.next_div_name = method + " " + file
		@mup.new_div!("normal", "", true) do
			@mup.div("class" => "file") do
				@mup.span( method + " ", "class" => "method")
				@mup.span( file, "class" => "name")
			end
		end

	end

	
	# text that is part of a message to appear later
	def message_prefix( line )
		@mup.accumulate!( line )
	end
	
	# Anything we don't parse specially
	def build_noise( line )
		@mup.normal!( line )
	end
	
	def play_sound(sound)
		%x{cd "#{$bundle}"; bin/play Sounds/#{sound} &}
	end
	
	def target_name(name)
		@mup.end_div!
		@mup.next_div_name = name
	end
	
	def success
		@mup.new_div!("info") { @mup.h2("Build Succeeded") }
		play_sound 'Harp.wav'

	end
	
	def failure
		@mup.new_div!("error") { @mup.h2("Build Failed") }
		play_sound 'Whistle.wav'
	end
	
end


# On with the show
load ($bundle + "/bin/parse_build.rb")
