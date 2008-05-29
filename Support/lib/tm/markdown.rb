module TextMate
	class Markdown
		def initialize(str, options = { })
			@str = str
			@filters = [ ]
			@filters << '"${TM_MARKDOWN:-$TM_SUPPORT_PATH/bin/Markdown.pl}"' unless options[:no_markdown]
			@filters << '"${TM_SMARTYPANTS:-$TM_SUPPORT_PATH/bin/SmartyPants.pl}"' unless options[:no_smartypants]
		end

		def to_html
			return @str if @filters.empty?

			IO.popen(@filters.join('|'), 'r+') do |io|
				Thread.new { io << @str; io.close_write }
				io.read
			end
		end
	end
end

if $0 == __FILE__
	puts TextMate::Markdown.new("who's there?").to_html
	puts TextMate::Markdown.new("who's there?", :no_markdown => true).to_html
	puts TextMate::Markdown.new("who's there?", :no_smartypants => true).to_html
	puts TextMate::Markdown.new("who's there?", :no_markdown => true, :no_smartypants => true).to_html
end
