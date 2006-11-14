require "escape"
require "web_preview"

require 'open3'
require 'cgi'
require 'fcntl'

$SCRIPTMATE_VERSION = "$Revision: 6031 $"

class UserScript
  # execmatch will be substituted into the #! match.  so write a regular
  # expression that can recognize the language you want to run.
  # in python, we:
  #  @@execmatch = "python(\d.\d)?"
  @@execmatch = ""
  # @@execargs is an array of arguments you want to pass to the executable.
  @@execargs = []
  @@write_content_to_stdin = true
  def initialize
    @content = STDIN.read
    @arg0 = $1       if @content =~ /\A#!([^ \n]*(?:env\s+)?#{@@execmatch})/
    @args = $1.split if @content =~ /\A#![^ \n]*(?:env\s+)?#{@@execmatch}[ \t]+(.*)$/
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
  def filter_args(*args)
    # args are filtered through this function before the script is run.
    args
  end
  def executable
    # return the path to the executable that will run @content.
  end

  def version_string
    # return the version string of the executable.
  end

  def run
    rd, wr = IO.pipe
    rd.fcntl(Fcntl::F_SETFD, 1)
    ENV['TM_ERROR_FD'] = wr.to_i.to_s
    args = [executable, @@execargs, Array(@args), e_sh(@path), ARGV.to_a ].flatten
    args = filter_args(args)
    stdin, stdout, stderr = Open3.popen3(args.join(" "))
    if @@write_content_to_stdin
      Thread.new { stdin.write @content; stdin.close } unless ENV.has_key? 'TM_FILEPATH'
    end
    wr.close
    [ stdout, stderr, rd ]
  end
  attr_reader :display_name, :path
end

class ScriptMate
  @@matename = "ScriptMate" # eg. RubyMate, PyMate, PerlMate...
  @@langname = "LanguageName" # eg. Python, Ruby, Perl...
  def initialize(script)
    @error = ""
    STDOUT.sync = true
    @script = script
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
    puts html_head(:window_title => "#{@script.display_name} — #{@@matename}", :page_title => "#{@@matename}", :sub_title => "#{@@langname}")
    puts <<-HTML
<div class="#{@@matename.downcase}">		
<div><!-- first box containing version info and script output -->
<pre><strong>#{@@matename} r#{$SCRIPTMATE_VERSION[/\d+/]} running #{@script.version_string}</strong>
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
