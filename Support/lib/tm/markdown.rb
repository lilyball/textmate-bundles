module TextMate
  class Markdown
    def initialize(str)
      @str = str
    end

    def to_html
      IO.popen('"${TM_MARKDOWN:-$TM_SUPPORT_PATH/bin/Markdown.pl}"|"${TM_SMARTYPANTS:-$TM_SUPPORT_PATH/bin/SmartyPants.pl}"', 'r+') do |io|
        Thread.new { io << @str; io.close_write }
        io.read
      end
    end
  end
end

if $0 == __FILE__
  puts TextMate::Markdown.new("hello's there").to_html
end
