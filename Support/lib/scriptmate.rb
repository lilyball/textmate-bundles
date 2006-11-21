require "escape"
require "web_preview"

require 'open3'
require 'cgi'
require 'fcntl'

$SCRIPTMATE_VERSION = "$Revision: 6031 $"

class UserScript
  def initialize(content, write_content_to_stdin=true)
    @write_content_to_stdin = write_content_to_stdin
    @content = content
    #match the entire she-bang.
    @hashbang = $1 if @content =~ /\A#!(.*)$/
    if ENV.has_key? 'TM_FILEPATH' then
      @path = ENV['TM_FILEPATH']
      @display_name = File.basename(@path)
      # save file
      open(@path, "w") { |io| io.write @content }
    else
      @path = '-'
      @display_name = 'untitled'
    end
  end
  def executable
    # return the path to the executable that will run @content.
  end
  def args
    # return any arguments to be fed to the executable
    []
  end
  def filter_cmd(cmd)
    # this method is called with this list:
    #     [executable, args, e_sh(@path), ARGV.to_a ].flatten
    cmd
  end
  def version_string
    # return the version string of the executable.
  end
  def run
    rd, wr = IO.pipe
    rd.fcntl(Fcntl::F_SETFD, 1)
    ENV['TM_ERROR_FD'] = wr.to_i.to_s
    cmd = filter_cmd([executable, args, e_sh(@path), ARGV.to_a ].flatten)
    stdin, stdout, stderr = Open3.popen3(cmd.join(" "))
    if @write_content_to_stdin
      Thread.new { stdin.write @content; stdin.close } unless ENV.has_key? 'TM_FILEPATH'
    end
    wr.close
    [ stdout, stderr, rd ]
  end
  attr_reader :display_name, :path
end

class ScriptMate
  def initialize(script)
    @error = ""
    STDOUT.sync = true
    @script = script
    @mate = self.class.name
  end
  def filter_stdout(str)
    # strings from stdout are passed through this method before being printed
    htmlize(str)
  end
  def filter_stderr(str)
    # strings from stderr are passwed through this method before printing
    "<span style='color: red'>#{htmlize str}</span>"
  end
  def emit_html
    puts html_head(:window_title => "#{@script.display_name} — #{@mate}", :page_title => "#{@mate}", :sub_title => "#{@script.lang}")
    puts <<-HTML
<div class="#{@mate.downcase}">		
<div><!-- first box containing version info and script output -->
<pre><strong>#{@mate} r#{$SCRIPTMATE_VERSION[/\d+/]} running #{@script.version_string}</strong>
<strong>>>> #{@script.display_name}</strong>

<div style="white-space: normal; -khtml-nbsp-mode: space; -khtml-line-break: after-white-space;"> <!-- Script output -->
HTML

    stdout, stderr, stack_dump = @script.run
    descriptors = [ stdout, stderr, stack_dump ]

    descriptors.each { |fd| fd.fcntl(Fcntl::F_SETFL, Fcntl::O_NONBLOCK) }
    until descriptors.empty?
      select(descriptors).shift.each do |io|
        str = io.read
        if str.to_s.empty? then
          descriptors.delete io
          io.close
        elsif io == stdout then
          print filter_stdout(str)
        elsif io == stderr then
          print filter_stderr(str)
        elsif io == stack_dump then
          @error << str
        end
      end
    end
    puts '</div></pre></div>'
    puts @error
    puts '<div id="exception_report" class="framed">Program exited.</div>'
    puts '</div>'
    puts '</body></html>'
  end
end
