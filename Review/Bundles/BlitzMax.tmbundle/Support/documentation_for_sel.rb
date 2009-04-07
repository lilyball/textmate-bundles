#!/usr/bin/env ruby -wKU

if ENV['TM_BLITZMAX'].nil? then
	print "TM_BLITZMAX shell variable not set.\n\nPlease see the Help (⌃⌘T Help) command for more information."
	exit(1)
end

selection = ENV['TM_SELECTED_TEXT']
if selection.nil? then
	selection = ENV['TM_CURRENT_WORD']
end

CMD_REGEX=/(?ix)
# name 1
^(#{selection}\b)
(?:
	(?:
		# type name 2
		\sExtends\s([a-zA-Z_]\w*)
	|
		# function and such
		# return type 3
		(?: ( [^\(]* )
		# arguments 4
		( \( .* \) (?:\sNoDebug)? )?
		)
		# description 5
		(?: \s \: \s ( .*? ))?
	)
)
# docpath 6
\|(\/.+$)
/

bmaxPath = ENV['TM_BLITZMAX']
cmdTxt = bmaxPath+"/docs/html/Modules/commands.txt"

if File.exist?(cmdTxt) then
	cmdTxtIO = File.new(cmdTxt, 'r')
	
	cmdTxtIO.each_line do |line|
		if line =~ CMD_REGEX then
			puts "<meta http-equiv='Refresh' content='0;URL=tm-file:///#{bmaxPath}#{$6}'>"
			exit(0)
		end
	end
	exit(2)
else
	puts "commands.txt not found\nPlease rebuild your documentation"
	exit(1)
end
