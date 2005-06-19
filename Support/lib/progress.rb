
require 'English'

module TextMate

	def TextMate.call_with_progress( args, &block )
		output_filepath	= args[:output_filepath]		# path to open after execution
		
		title			= args[:title] || 'Progress'
		message			= args[:message] || 'Frobbing the widget...'
		
		cocoa_dialog	= "#{ENV['TM_SUPPORT_PATH']}/bin/CocoaDialog.app/Contents/MacOS/CocoaDialog"

		tempdir = "/tmp/TextMate_progress_cmd_tmp.#{$PID}"
		Dir.mkdir(tempdir)
		Dir.chdir(tempdir)
		pipe = IO.popen( %Q("#{cocoa_dialog}" progressbar --indeterminate --title "#{title}" --text "#{message}"), "w+")
		begin
			pipe.puts ""
			data = block.call
			if data != nil
				File.open(output_filepath, "w") do |file|
					file.write(data)
				end
			end

			%x({ open -a "$(ps xw -o command|grep '\\.app/Contents/MacOS/TextMate'|grep -v grep|sed 's/\\(.*\\.app\\).*/\\1/')" "#{output_filepath}"; sleep 30; rm -rf "#{tempdir}"; } </dev/null &>/dev/null &)
		ensure

			pipe.close
		end

		sleep 0.1
		
	end

end
