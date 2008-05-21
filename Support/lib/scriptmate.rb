SUPPORT_LIB = ENV['TM_SUPPORT_PATH'] + '/lib/'
require SUPPORT_LIB + 'escape'
require SUPPORT_LIB + 'web_preview'
require SUPPORT_LIB + 'process'

require 'shellwords'
require 'cgi'
require 'fcntl'

$KCODE = 'u'
require 'jcode'

$SCRIPTMATE_VERSION = "$Revision$"

def cmd_mate(cmd)
  # cmd can be either a string or a list of strings to be passed to TextMate::Process.run()
  # this command will write the output of the `cmd` on STDOUT, formatted in HTML.
  c = UserCommand.new(cmd)
  m = CommandMate.new(c)
  m.emit_html
end

class UserCommand
  attr_reader :display_name, :path
  def initialize(cmd)
    @cmd = cmd
  end
  def run(&block)
    TextMate::Process.run(@cmd, :echo => true, &block)
    ""
  end
  def to_s
    @cmd.to_s
  end
end

class CommandMate
    def initialize (command)
      # the object `command` needs to implement a method `run`.  `run` should
      # accept a 2 argument block, where the first arg is a chunk of output and the 
      # second arg specifies whether the output came from stdout (:out) or stderr (:err).
      # It can optionally return HTML to be output after the command has terminated 
      # (e.g. a stacktrace)
      @error = ""
      @command = command
      STDOUT.sync = true
      @mate = self.class.name
    end
  protected
    def filter_stdout(str)
      # strings from stdout are passed through this method before being printed
      htmlize(str).gsub(/\<br\>/, "<br>\n")
    end
    def filter_stderr(str)
      # strings from stderr are passwed through this method before printing
      "<span style='color: red'>#{htmlize str}</span>".gsub(/\<br\>/, "<br>\n")
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
      emit_header()
      @error = @command.run do |str, type|
        case type
          when :out   then print filter_stdout(str)
          when :err   then puts filter_stderr(str)
        end
      end
      emit_footer()
    end
end

class UserScript
  attr_reader :display_name, :path, :warning
  def initialize(content, write_content_to_stdin=true)
    @warning = nil
    @write_content_to_stdin = write_content_to_stdin
    @content = content
    # match the entire she-bang.
    @hashbang = $1 if @content =~ /\A#!(.*)$/
    if ENV.has_key? 'TM_FILEPATH' then
      @path = ENV['TM_FILEPATH']
      @display_name = File.basename(@path)
      # save file
      begin
        open(@path, "w") { |io| io.write @content }
      rescue Errno::EACCES
        @path = '-'
        @display_name += ' '
        @warning = "File could not be saved before run."
      end
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
      #     [executable, args, @path, ARGV.to_a ].flatten
      cmd
    end
    def version_string
      # return the version string of the executable.
    end
    def env
      # return a hash of environment variables to set for the process
      nil
    end
    def granularity
      # return an output buffer size, or :line for line by line output
      :line
    end
    def echo
      # Return whether any interactive input will be echoed to the output or not
      true
    end
    def run(&block)
      stack_rd, stack_wr = IO.pipe
      stack_rd.fcntl(Fcntl::F_SETFD, 1)
      ENV['TM_ERROR_FD'] = stack_wr.to_i.to_s

      exe = @hashbang.nil? ? executable : Shellwords.shellwords(@hashbang)
      cmd = filter_cmd([exe, args, @path, ARGV.to_a].flatten)
      input = (@write_content_to_stdin and @path == '-') ? @content : nil
      TextMate::Process.run(cmd, :echo => echo, :input => input, :env => env, :granularity => granularity, &block)

      stack_wr.close
      stack_rd.read
    end
end

class ScriptMate < CommandMate

  protected
    def emit_header
      puts html_head(:window_title => "#{@command.display_name} — #{@mate}", :page_title => "#{@mate}", :sub_title => "#{@command.lang}")
      puts <<-HTML
<!-- scriptmate javascripts -->
<script type="text/javascript" charset="utf-8">
function press(evt) {
   if (evt.keyCode == 67 && evt.ctrlKey == true) {
      TextMate.system("kill -s INT #{@pid}; sleep 0.5; kill -s TERM #{@pid}", null);
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
    
    div#exception_report pre.snippet {
      margin:4pt;
      padding:4pt;
    }
  </style>
  <strong class="warning" style="float:left; color:#B4AF00;">#{@command.warning}</strong>
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
