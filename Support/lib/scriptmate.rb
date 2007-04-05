require "escape"
require "web_preview"

require 'open3'
require 'cgi'
require 'fcntl'

$SCRIPTMATE_VERSION = "$Revision$"

def my_popen3(*cmd) # returns [stdin, stdout, strerr, pid]
  pw = IO::pipe   # pipe[0] for read, pipe[1] for write
  pr = IO::pipe
  pe = IO::pipe

  pid = fork{
    pw[1].close
    STDIN.reopen(pw[0])
    pw[0].close

    pr[0].close
    STDOUT.reopen(pr[1])
    pr[1].close

    pe[0].close
    STDERR.reopen(pe[1])
    pe[1].close

    exec(*cmd)
  }

  pw[0].close
  pr[1].close
  pe[1].close

  pw[1].sync = true

  [pw[1], pr[0], pe[0], pid]
end

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
    stdin, stdout, stderr, pid = my_popen3(@cmd)
    return stdout, stderr, nil, pid
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
  protected
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
      html_footer
    end
  public
    def emit_html
      stdout, stderr, stack_dump, @pid = @command.run
      emit_header()
      descriptors = [ stdout, stderr, stack_dump ].compact
      descriptors.each do
         |fd| fd.fcntl(Fcntl::F_SETFL, Fcntl::O_NONBLOCK)
      end
      until descriptors.empty?
        select(descriptors).shift.each do |io|
          str = io.read
          if str.to_s.empty? then
            descriptors.delete io
            io.close
          elsif io == stdout then
            print filter_stdout(str)
          elsif io == stderr then
            puts filter_stderr(str)
          elsif io == stack_dump then
            @error << str
          end
        end
      end
      emit_footer()
      Process.waitpid(@pid)
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
  public
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
      stdin, stdout, stderr, pid = my_popen3(cmd.join(" "))
      if @write_content_to_stdin
        Thread.new { stdin.write @content; stdin.close } unless ENV.has_key? 'TM_FILEPATH'
      end
      wr.close
      [ stdout, stderr, rd, pid ]
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

  protected
    def emit_header
      puts html_head(:window_title => "#{@command.display_name} — #{@mate}", :page_title => "#{@mate}", :sub_title => "#{@command.lang}")
      puts <<-HTML
<!-- scriptmate javascripts -->
<script type="text/javascript" charset="utf-8">
function press(evt) {
   if (evt.keyCode == 67 && evt.ctrlKey == true) {
      TextMate.system("kill -s INT #{@pid}", null);
   }
}
document.body.addEventListener('keydown', press, false);

function copyOutput(link) {
  output = document.getElementById('_scriptmate_output').innerText;
  cmd = TextMate.system('__CF_USER_TEXT_ENCODING=$UID:0x8000100:0x8000100 /usr/bin/pbcopy', function(){});
  cmd.write(output);
  cmd.close();
  link.innerText = 'output copied to clipboard';
}
</script>
<!-- end javascript -->
HTML
      puts <<-HTML
  <style type="text/css">
    /* =================== */
    /* = ScriptMate Styles = */
    /* =================== */

    div.scriptmate {
    }

    div.scriptmate > div {
    	/*border-bottom: 1px dotted #666;*/
    	/*padding: 1ex;*/
    }

    div.scriptmate pre em
    {
    	/* used for stderr */
    	font-style: normal;
    	color: #FF5600;
    }

    div.scriptmate div#exception_report
    {
    /*	background-color: rgb(210, 220, 255);*/
    }

    div.scriptmate p#exception strong
    {
    	color: #E4450B;
    }

    div.scriptmate p#traceback
    {
    	font-size: 8pt;
    }

    div.scriptmate blockquote {
    	font-style: normal;
    	border: none;
    }


    div.scriptmate table {
    	margin: 0;
    	padding: 0;
    }

    div.scriptmate td {
    	margin: 0;
    	padding: 2px 2px 2px 5px;
    	font-size: 10pt;
    }

    div.scriptmate a {
    	color: #FF5600;
    }
  </style>
  <div class="scriptmate #{@mate.downcase}">
  <div class="controls" style="text-align:right;">
    <a style="text-decoration: none;" href="#" onclick="copyOutput(document.getElementById('_script_output'))">copy output</a>
  </div>
  <!-- first box containing version info and script output -->
  <pre>
<strong>#{@mate} r#{$SCRIPTMATE_VERSION[/\d+/]} running #{@command.version_string}</strong>
<strong>>>> #{@command.display_name}</strong>

<div id="_scriptmate_output" style="white-space: normal; -khtml-nbsp-mode: space; -khtml-line-break: after-white-space;"> <!-- Script output -->
  HTML
    end

    def emit_footer
      puts '</div></pre></div>'
      puts @error unless @error == ""
      puts '<div id="exception_report" class="framed">Program exited.</div>'
      html_footer
    end
end
