# tm/executor.rb
#
# Provides some tools to create “Run Script” commands
# that fancily HTML format stdout/stderr.
#
# Nice features include:
#  • Automatic interactive input.
#  • Automatic Fancy HTML headers
#  • The environment variable TM_ERROR_FD will contain a file descriptor to which HTML-formatted
#    exceptions can be written.
#
# Executor runs best if TextMate.save_current_document is called first.  Doing so ensures
# that TM_FILEPATH contains the path to the contents of your current document, even if the
# current document has not yet been saved, or the file is unwriteable.
#
# Call it like this (you'll get rudimentary htmlification of the executable's output):
#
#   TextMate::Executor.run(ENV['TM_SHELL'] || ENV['SHELL'] || 'bash', ENV['TM_FILEPATH'])
#
# Or like this if you want to transform the output yourself:
#
#   TextMate::Executor.run(ENV['TM_SHELL'] || ENV['SHELL'] || 'bash', ENV['TM_FILEPATH']) do |str, type|
#     str = htmlize(str)
#     str =  "<span class=\"stderr\">#{htmlize(str)}</span>" if type == :out
#   end
#
#  TextMate::Executor.run also accepts three optional named arguments.
#    :version_args are arguments that will be passed to the executable to generate a version string for use as the page's subtitle.
#    :version_regex is a regular expression to which the resulting version string is passed.
#      $1 of this regex is used as the subtitle of the Executor.run output.  By default, this just takes the first line.
#    :env is the environment in which the command will be run.  Default is ENV.

SUPPORT_LIB = ENV['TM_SUPPORT_PATH'] + '/lib/'
require SUPPORT_LIB + 'tm/process'
require SUPPORT_LIB + 'tm/tempfile'
require SUPPORT_LIB + 'tm/htmloutput'
require SUPPORT_LIB + 'escape'
require SUPPORT_LIB + 'io'

$KCODE = 'u'
require 'jcode'

$stdout.sync = true

module TextMate
  module Executor
    class << self

      # Textmate::Executor.run
      #   Provides an API function for running

      def run(*args, &block)

        args.flatten!

        options = {:version_args  => ['--version'],
                   :version_regex => /\A(.*)$/,
                   :env           => ENV,
                   :script_args   => []}

        options.merge! args.pop if args.last.is_a? Hash

        args[0] = ($1.chomp.split if /\A#!(.*)$/ =~ File.read(args[-1])) || args[0]

        tm_error_fd_read, tm_error_fd_write = ::IO.pipe
        tm_error_fd_read.fcntl(Fcntl::F_SETFD, 1)
        ENV['TM_ERROR_FD'] = tm_error_fd_write.to_i.to_s

        # version = $1 if options[:version_regex] =~ Process.run(args[0], options[:version_args], :interactive_input => true)[0]
        version = $1 if options[:version_regex] =~ `#{e_sh args[0]} #{options[:version_args].flatten.join(" ")}`

        options[:script_args].each { |arg| args << arg }

        TextMate::HTMLOutput.show(:title => "Running “#{ENV['TM_DISPLAYNAME']}”…", :sub_title => version) do |io|

          block ||= proc do |str, type|
            str = htmlize(str).gsub(/\<br\>/, "<br>\n")
            str = "<span style='color: red'>#{str}</span>" if type == :err
            str
          end

          callback = proc {|str, type| io << block.call(str,type)}
          process_output_wrapper(io) do
            TextMate::Process.run(args, :env => options[:env], :echo => true, &callback)
          end

          tm_error_fd_write.close
          error = tm_error_fd_read.read
          tm_error_fd_read.close

          if ENV.has_key? "TM_FILE_IS_UNTITLED"
            # replace links to temporary file with links to current (unsaved) file, by removing
            # the url option from any txmt:// links.
            error.gsub!("url=file://#{ENV['TM_FILEPATH']}", '')
            error.gsub!("url=file://#{e_url ENV['TM_FILEPATH']}", '')
            error.gsub!(ENV['TM_FILENAME'], "untitled")
            error.gsub!(e_url(ENV['TM_FILENAME']), "untitled")
          elsif ENV.has_key? 'TM_ORIG_FILEPATH'
            error.gsub!(ENV['TM_FILEPATH'], ENV['TM_ORIG_FILEPATH'])
            error.gsub!(e_url(ENV['TM_FILEPATH']), e_url(ENV['TM_ORIG_FILEPATH']))
            error.gsub!(ENV['TM_FILENAME'], ENV['TM_ORIG_FILENAME'])
            error.gsub!(e_url(ENV['TM_FILENAME']), e_url(ENV['TM_ORIG_FILENAME']))
          end

          io << error
          io << '<div id="exception_report" class="framed">Program exited.</div>'
        end
      end

      private

      def process_output_wrapper(io)
        io << <<-HTML
<!-- executor javascripts -->
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
<style type="text/css">

  div.executor pre em
  {
    font-style: normal;
    color: #FF5600;
  }

  div.executor p#exception strong
  {
    color: #E4450B;
  }

  div.executor p#traceback
  {
    font-size: 8pt;
  }

  div.executor blockquote {
    font-style: normal;
    border: none;
  }

  div.executor table {
    margin: 0;
    padding: 0;
  }

  div.executor td {
    margin: 0;
    padding: 2px 2px 2px 5px;
    font-size: 10pt;
  }

  div.executor a {
    color: #FF5600;
  }

  div#exception_report pre.snippet {
    margin:4pt;
    padding:4pt;
  }
</style>
<div class="executor">
<div class="controls" style="text-align:right;">
  <a style="text-decoration: none;" href="#" onclick="copyOutput(document.getElementById('_executor_output'))">copy output</a>
</div>
<!-- first box containing version info and script output -->
<pre>
<div id="_executor_output" style="white-space: normal; -khtml-nbsp-mode: space; -khtml-line-break: after-white-space;"> <!-- Script output -->
HTML
        yield
        io << '</div></pre></div>'
      end
    end
  end
end


