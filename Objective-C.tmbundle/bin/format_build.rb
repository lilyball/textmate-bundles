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

div{
	position: relative;
}

div.showhide {
#	width: 100%;
#	float: right;
	position: absolute;
	right: 20px;
	font-size: 8pt;
	font-family: "Lucida Grande", sans-serif;
	margin-top: 2px;
	margin-bottom: 2px;
	margin-right: 0px;
}

div.target {
	padding: 2px;
	margin: 3px;

	border: 2px;
	border-style: none none none solid;
	color: #aaa;
	background-color: #eee;
	font-size: 70%;
	margin 0;
}

div.target span.name {
	margin-top: 2px;
	margin-bottom: 2px;
	color: #777;
}

div.command span.name {
	font-size: 8pt;
	margin-top: 2px;
	margin-bottom: 2px;
	color: #000;
}

div.command span.method {
	font-size: 8pt;
	margin-top: 2px;
	margin-bottom: 2px;
	color: #777;
}

div.target h2 {
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

div.error div.inner :link, div.warning div.inner :link, div.info div.inner :link {
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
			
			attr_writer		:div_stack			# stack of nested div classes
			attr_accessor	:div_count			# absolute count of divs
			attr_accessor	:accumulated_prefix	# prefix text to insert in next div
			
			def div_stack
				@div_stack = Array.new unless defined?(@div_stack)
				@div_stack
			end
			
			def current_div
				div_stack.last
			end
			
			def start_tag!(tag)
				_start_tag( tag, nil )
			end
			
			def end_tag!(tag)
				_end_tag(tag)
			end
			
			def _start_tag( tag, thing, thingtwo = nil )
#				puts "[start:#{tag}]"
				super
			end
			
			def _end_tag(tag)
#				puts "[end:#{tag}]"
				super
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
			
			# div hierarchy:
			# 1. target; target (BUILD NATIVE TARGET "Frobozz" .*)
			# 2.	command; build commands (CompileC .*)
			# 3.		details; build details (g++-3.3 .*)
			# 4.		info, warning, error; build warnings/errors -- actually a sibling of the build commands, so that they default to visible but are still hidden with the target.
			# Note that the client is partly responsible for maintaining the hierarchy.

			STACK_LEVEL_TOP = 1
			STACK_LEVEL_COMMAND_AND_ERRORS = 2
			STACK_LEVEL_DETAILS = 3

			STACK_LEVEL_TABLE = {'target' => 1,
								'command' => 2,
								'details' => 3,
								'info' => 2,
								'error' => 2,
								'warning' => 2}
			
			def stacklevel_for_class(newclass)
				
				stacklevel = STACK_LEVEL_TABLE[newclass]
				stacklevel = 0 if stacklevel.nil?
				stacklevel
			end
			
			# pop appropriate divs for newclass
			def autopop(newclass)
				new_level		= stacklevel_for_class(newclass)
				current_level	= stacklevel_for_class(current_div)

				case
					# top level replaces top level on the stack
					when new_level == current_level
						end_div!(current_div)
					
					when new_level > current_level
						# only commands have details; errors do not.
						if (newclass == 'details') and
							(current_div != 'command') and
							(current_level == STACK_LEVEL_COMMAND_AND_ERRORS)
							end_div_count!(1)
						end
					
					when new_level < current_level
						end_div_count!(current_level - new_level)
						# and recurse to check for equal level
						autopop(newclass)
				end
				
			end
			
			# accumulative div -- block yields the div title
			# visibility can be :visible, :hidden, :always_visible
			def new_div!( nclass, content = "", visibility = :show, &block )
				div_id = nil
				
				@div_count = 0 unless defined?(@div_count)
				@accumulated_prefix = '' unless defined?(@accumulated_prefix)
				
				unless nclass === current_div
					@div_count += 1
					div_id = "z_" + @div_count.to_s
					
					# end the old div
					autopop(nclass)
					
					# start the new div and the inner content div
					div_stack.push nclass

					_start_tag( "div", "class" => nclass, "id" => div_id )

#					visibility = :show_always   # debugging
					if (visibility == :hide) or (visibility == :show) then

						hide_if_hidden_style = (visibility == :hide) ? "display: none;" : "";
						show_if_hidden_style = (visibility == :hide) ? "" : "display: none;";

						# add show/hide toggle above the inner content div
						div( "class" => "showhide" ) {
						
							a( "Hide Details", 'href' => "javascript:hideElement('#{div_id}')", 'id' => div_id + '_hide', 'style' => hide_if_hidden_style )
							a( "Show Details", 'href' => "javascript:showElement('#{div_id}')", 'id' => div_id + '_show', 'style' => show_if_hidden_style )
						}
					end
					
					block.call unless block.nil?

					# show the user at least the title of the div
					STDOUT.flush
					
					_start_tag( "div", "class" => "inner", "id" => div_id + "_c", 'style' => hide_if_hidden_style )
					
				end
				
				# output the div prefix for error/message boxes
				unless @accumulated_prefix.empty? || current_div == 'target'
					
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
			def end_div!( popdiv )
				if div_stack.include?(popdiv)
					loop do
#						puts "pop #{div_stack.last}: #{div_stack.inspect}"
						_end_tag("div")	# inner
						_end_tag("div")	# outer
						break if (@div_stack.pop == popdiv || @div_stack.size == 0)
					end
				end
			end

			def end_div_count!( count )
				count.times do
#					puts "pop #{div_stack.last}: #{div_stack.inspect}"
					 div_stack.pop
					_end_tag("div")	# inner
					_end_tag("div")	# outer
				end
			end

			def normal!(string)
				# build noise, either part of the toplevel target info or part of the details of a build command
				divclass = (stacklevel_for_class(current_div) > STACK_LEVEL_TOP) ? "details" : "target"
				new_div!( divclass, string, (divclass == "target") ? :show : :always_show )
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
		@mup.end_div!("target")

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
		@mup.end_div!("command")
		@mup.new_div!("command", "", :hide) do
#			@mup.div("class" => "command") do
				@mup.span( method + " ", "class" => "method")
				@mup.span( file, "class" => "name")
#			end
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
	
	def target_name(name, style = nil)
		@mup.end_div!("target")
		
		@mup.new_div!("target") do
		
			if style.nil? or style.empty? then
				@mup.h2(name)
			else
				@mup.h2 do
					@mup.text!("Building ")
					@mup.span(name, 'class' => 'name')
					@mup.text!(" with build style ")
					@mup.span(style, 'class' => 'name')
				end

			end	
		end
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
