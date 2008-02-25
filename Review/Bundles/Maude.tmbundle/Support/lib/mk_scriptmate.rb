SUPPORT_LIB = ENV['TM_SUPPORT_PATH'] + '/lib/'
require SUPPORT_LIB + 'io'
require SUPPORT_LIB + 'escape'
require SUPPORT_LIB + 'web_preview'

require 'fcntl'

class UserScript
  attr_reader :name, :path
  
  def initialize(content, argv = nil, read_from_stdin = true, &block)
    @read_from_stdin = read_from_stdin
    @content = content
    @block = block
    @argv = argv || ARGV.to_a
    @hashbang = $1 if @content =~ /\A#!(.*)$/
    @path = '-'
    @name = 'untitled'
    if ENV.has_key?('TM_FILEPATH') then
      @name = ENV['TM_FILENAME']
      unless @read_from_stdin
        @path = ENV['TM_FILEPATH']
        open(@path, 'w') { |io| io.write(@content) }
      end
    end
  end
  
  protected
    def popen3(*cmd)
      # like Open3.popen3, but returns [stdin, stdout, strerr, pid]
      # pipe[0] for read, pipe[1] for write
      pin  = IO::pipe
      pout = IO::pipe
      perr = IO::pipe

      pid = fork {
        pin[1].close
        STDIN.reopen(pin[0])
        pin[0].close

        pout[0].close
        STDOUT.reopen(pout[1])
        pout[1].close

        perr[0].close
        STDERR.reopen(perr[1])
        perr[1].close

        exec(*cmd)
      }

      pin[0].close
      pout[1].close
      perr[1].close

      pin[1].sync = true

      [pin[1], pout[0], perr[0], pid]
    end
  
    def command_line(argv)
      # return the command line that will be invoked.
      cmd = filter_cmd(executable, args, e_sh(@path), argv)
      cmd = cmd.flatten.join(' ') unless String === cmd
      cmd
    end
    
  public
    def lang
      # return the name of the language that @content uses.
      'Unknown'
    end
    
    def executable
      # return the path to the executable that will run @content.
    end
    
    def args
      # return any arguments to be passed to the executable.
      []
    end
    
    def version_string
      # return the version string of the executable.
      %x{#{executable} --version 2>&1}.chomp + " (#{executable})"
    end
    
    def filter_cmd(exec, args, path, argv)
      # return the elements of the command line that will be invoked.
      [exec, args, path, argv]
    end
    
    def run
      # return [stdout, stderr, stack_dump, pid]
      rd, wr = IO.pipe
      rd.fcntl(Fcntl::F_SETFD, 1)
      ENV['TM_ERROR_FD'] = wr.to_i.to_s
      cmd = command_line(@argv)
      stdin, stdout, stderr, pid = popen3(cmd)
      Thread.new do
        stdin.write @content if @read_from_stdin
        @block.call stdin if @block
        stdin.close
      end
      wr.close
      [stdout, stderr, rd, pid]
    end
end

class CommandMate
  def initialize(command)
    # command.should.respond_to? :run
    # command.run.should == [stdout, stderr, stack_dump, pid]
    @error = ''
    @command = command
    @mate = self.class.name
    @retval = nil
    STDOUT.sync = true
  end
  
  protected
    def filter_stdout(str)
      # strings from stdout are passed through this method before printing
      htmlize(str).gsub(/\<br\>/, "<br>\n")
    end
    
    def filter_stderr(str)
      # strings from stderr are passwd through this method before printing
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
      stdout, stderr, stack_dump, @pid = @command.run
      %w[INT TERM].each do |signal|
        trap(signal) do
          begin
            Process.kill("KILL", @pid)
            sleep 0.5
            Process.kill("TERM", @pid)
          rescue
            # process doesn't exist anymore
          end
        end
      end
      emit_header()
      TextMate::IO.exhaust(:out => stdout, :err => stderr, :stk => stack_dump) do |str, type|
        case type
        when :out then puts filter_stdout(str).to_s
        when :err then puts filter_stderr(str).to_s
        when :stk then @error << str
        end
      end
      emit_footer()
      Process.waitpid(@pid)
      return @retval if @retval
      return 1 unless @error == ''
      return 0
    end
end

class ScriptMate < CommandMate
  # @command.name.should == "Displayed name of the script"
  # @command.land.should == "Language used in the script"
  # @command.version_string.should == "Version of the script interpreter"
  protected
    def emit_header
      puts html_head(:window_title => "#{@command.name} — #{@mate}", :page_title => "#{@mate}", :sub_title => "#{@command.lang}")
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

    div.scriptmate pre em {
    	/* used for stderr */
    	font-style: normal;
    	color: #FF5600;
    }

    div.scriptmate div#exception_report
    {
    	/*background-color: rgb(210, 220, 255);*/
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
<strong>>>> #{@command.name}</strong>

<div id="_scriptmate_output" style="white-space: normal; -khtml-nbsp-mode: space; -khtml-line-break: after-white-space;"> <!-- Script output -->
  HTML
    end
    
    def emit_footer
      puts '</div></pre></div>'
      puts <<-HTML
<div id="exception_report" class="framed">
  #{filter_stack(@error) unless @error == ''}
  Program exited.
</div>
      HTML
      html_footer
    end
  
  public
    def filter_stack(str)
      # strings from the stack dump are passed through this method before printing
      # htmlize(str).gsub(/\<br\>/, "<br>\n")
      str
    end
end
