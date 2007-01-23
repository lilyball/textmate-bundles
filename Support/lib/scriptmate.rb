require "escape"
require "web_preview"

require 'open3'
require 'cgi'
require 'fcntl'

$SCRIPTMATE_VERSION = "$Revision$"

def cmd_mate(cmd)
  # cmd can be either a string or a list of strings to be passed to Popen3
  # this command will write the output of the `cmd` on STDOUT, formatted in
  # HTML.
  c = UserCommand.new(cmd)
  m = CommandMate.new(c)
  m.emit_html
end

class UserCommand
  attr_reader :display_name, :path
  def initialize(cmd)
    @cmd = cmd
  end
  def run
    stdin, stdout, stderr = Open3.popen3(@cmd)
    return stdout, stderr, open("/dev/null")
  end
  def to_s
    @cmd.to_s
  end
end

class CommandMate
  def initialize (command)
    # the object `command` needs to implement a method `run`.  `run` should
    # return an array of three file descriptors [stdout, stderr, stack_dump].
    @error = ""
    @command = command
    STDOUT.sync = true
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
  def emit_header
    puts html_head(:window_title => "#{@command}", :page_title => "#{@command}", :sub_title => "")
    puts "<pre>"
  end
  def emit_footer
    puts "</pre>"
    puts html_footer
  end
  def emit_html
    emit_header()
    stdout, stderr, stack_dump = @command.run
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
    emit_footer()
  end
end

class UserScript
  attr_reader :display_name, :path
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
end

class ScriptMate < CommandMate
  def initialize(command)
    # ScriptMate expects an instance of the (sub)class UserScript.
    @error = ""
    STDOUT.sync = true
    @command = command
    @mate = self.class.name
  end

  def emit_header
    puts html_head(:window_title => "#{@command.display_name} — #{@mate}", :page_title => "#{@mate}", :sub_title => "#{@command.lang}")
    puts <<-HTML
<div class="#{@mate.downcase}">		
<div><!-- first box containing version info and script output -->
<pre><strong>#{@mate} r#{$SCRIPTMATE_VERSION[/\d+/]} running #{@command.version_string}</strong>
<strong>>>> #{@command.display_name}</strong>

<div style="white-space: normal; -khtml-nbsp-mode: space; -khtml-line-break: after-white-space;"> <!-- Script output -->
HTML
  end

  def emit_footer
    puts '</div></pre></div>'
    puts @error
    puts '<div id="exception_report" class="framed">Program exited.</div>'
    puts '</div>'
    puts '</body></html>'
  end
end
