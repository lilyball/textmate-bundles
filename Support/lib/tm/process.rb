# -----------------------
# TextMate::Process.run()
# -----------------------
# Method for opening processes under TextMate.
#
# # BASIC USAGE
#
# 1. out, err = TextMate::Process.run("svn", "commit", "-m", "A commit message")
#
#   'out' and 'err' are the what the process produced on stdout and stderr respectively.
#
# 2. TextMate::Process.run("svn", "commit", "-m", "A commit message") do |str, type|
#   case type
#   when :out
#     STDOUT << str
#   when :err
#     STDERR << str
#   end
# end
#
#   The block will be called with the output of the process as it becomes available.
#
# 3. TextMate::Process.run("svn", "commit", "-m", "A commit message") do |str|
#   STDOUT << str
# end
#
#   Similar to 2, except that the type of the output is not passed.
#
# # OPTIONS
#
# The last (non block) argument to run() can be a Hash that will augment the behaviour.
# The available options are (with default values in parenthesis)…
#
# * :interactive_input (true)
#
# Inject the interactive input library into the program so that any requests for
# input present the user with a dialog to enter it.
#
# * :echo (false)
#
# If using interactive input, echo the user's input onto the output
# (has no effect if interactive input is off).
#
# * :granularity (:line)
#
# The size of the buffer to use to read the process output. The value :line
# indicates that output will be passed a line at a time. Any other non integer
# value will result in an unspecified buffer size being used.
#
# * :input (nil)
#
# A string to send to the stdin of the process.
#
# * :env (nil)
#
# A hash of environment variables to set for the process.
#
# NOTES
#
# The following is not valid Ruby…
#
#   args = ["commit", "-m", "commit message"]
#   TextMate::Process("svn", *args, :buffer => true)
#
# To get around this, arguments to run() are flattened. This allows the
# almost as good version…
#
#   args = ["commit", "-m", "commit message"]
#   TextMate::Process("svn", args, :buffer => true)
#

require ENV['TM_SUPPORT_PATH'] + '/lib/io'
require 'fcntl'

module TextMate
  module Process
    class << self

      TM_INTERACTIVE_INPUT_DYLIB = ENV['TM_SUPPORT_PATH'] + '/lib/tm_interactive_input.dylib'
      def run(*cmd, &block)

        cmd.flatten!

        options = {
          :interactive_input => true,
          :echo => false,
          :granularity => :line,
          :input => nil,
          :env => nil,
          :watch_fds => { },
        }

        options.merge! cmd.pop if cmd.last.is_a? Hash

        io = []
        3.times { io << ::IO::pipe }

        # F_SETOWN = 6, ideally this would be under Fcntl::F_SETOWN
        io[0][0].fcntl(6, ENV['TM_PID'].to_i) if ENV.has_key? 'TM_PID'

        pid = fork {
          
          at_exit { exit! }
          
          STDIN.reopen(io[0][0])
          STDOUT.reopen(io[1][1])
          STDERR.reopen(io[2][1])

          io.flatten.each { |fd| fd.close }

          options[:env].each { |k,v| ENV[k] = v } unless options[:env].nil?

          if options[:interactive_input] and File.exists? TM_INTERACTIVE_INPUT_DYLIB
            dil = ENV['DYLD_INSERT_LIBRARIES']
            if dil.nil? or dil.empty?
              ENV['DYLD_INSERT_LIBRARIES'] = TM_INTERACTIVE_INPUT_DYLIB
            elsif not dil.include? TM_INTERACTIVE_INPUT_DYLIB
              ENV['DYLD_INSERT_LIBRARIES'] = "#{TM_INTERACTIVE_INPUT_DYLIB}:#{dil}"
            end

            ENV['DYLD_FORCE_FLAT_NAMESPACE'] = "1"
            ENV['TM_INTERACTIVE_INPUT'] = "AUTO" + ((options[:echo]) ? "|ECHO" : "")
          end

          exec(*cmd.compact)
        }

        %w[INT TERM].each do |signal|
          trap(signal) do
            begin
              Process.kill("KILL", pid)
              sleep 0.5
              Process.kill("TERM", pid)
            rescue
              # process doesn't exist anymore
            end
          end
        end

        [ io[0][0], io[1][1], io[2][1] ].each { |fd| fd.close }

        if echo_fd = ENV['TM_INTERACTIVE_INPUT_ECHO_FD']
          ::IO.for_fd(echo_fd.to_i).close
          ENV.delete('TM_INTERACTIVE_INPUT_ECHO_FD')
        end

        if options[:input].nil?
          io[0][1].close
        else
          Thread.new { (io[0][1] << options[:input]).close }
        end

        out = ""
        err = ""

        block ||= proc { |str, fd|
          case fd
            when :out then out << str
            when :err then err << str
          end
        }

        previous_block_size = IO.blocksize
        IO.blocksize = options[:granularity] if options[:granularity].is_a? Integer
        previous_sync = IO.sync
        IO.sync = true unless options[:granularity] == :line

        IO.exhaust(options[:watch_fds].merge(:out => io[1][0], :err => io[2][0]), &block)
        ::Process.waitpid(pid)

        IO.blocksize = previous_block_size
        IO.sync = previous_sync

        block_given? ? nil : [out,err]
      end

    end
  end
end