module TextMate

	def TextMate.join_path (abs, file)
		file[0] == ?/ ? file : File.join(abs, file)
	end

	def TextMate.url_esc (url)
		url.gsub(/[^a-zA-Z0-9.-\/]/) { |m| sprintf("%%%02X", m[0]) }
	end

	def TextMate.html_esc (text)
		text.gsub(/</, '&lt;').gsub(/&/, '&amp;')
	end

	def TextMate.parse_errors
		print '<pre style="word-wrap: break-word;">'
		STDIN.each_line do |line|
			line = line.chop
			if m = /^(.*?):(?:(\d+):)?\s*(.*?)$/.match(line) then
				file, no, error = m[1..3]
				file = join_path(ENV['PWD'], file)
				if File.exists?(file)
					print "<a href='txmt://open?url=file://#{url_esc file}"
					print "&line=#{no}" unless no.nil?
					print "'>#{html_esc error}</a><br>"
				else
					print html_esc(line) + '<br>'
				end
			else
				print html_esc(line) + '<br>'
			end
		end
		print '</pre>'
	end

end
