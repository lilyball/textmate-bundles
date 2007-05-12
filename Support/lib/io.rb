module TextMate
  module IO
    class << self
      def exhaust(named_fds, &block)
        named_fds = named_fds.dup
        named_fds.delete_if { |key, value| value.nil? }

        until named_fds.empty? do
          fd = select(named_fds.values)[0][0]
          data = fd.sysread(4096) rescue ""
          if data.to_s.empty? then
            named_fds.delete_if { |key, value| fd == value }
            fd.close
          else
            case block.arity
              when 1: block.call(data)
              when 2: block.call(data, named_fds.find { |key, value| fd == value }.first)
            end
          end
        end
      end
    end
  end
end

# interactive unit tests
if $0 == __FILE__

  require "open3"

  stdin, stdout, stderr = Open3.popen3('echo foo; echo 1>&2 bar; echo fud')
  TextMate::IO.exhaust(:out => stdout, :err => stderr) do |data, type|
    puts "#{type}: #{data}"
  end

  puts "----"

  stdin, stdout, stderr = Open3.popen3('echo foo; echo 1>&2 bar; echo fud')
  TextMate::IO.exhaust(:out => stdout, :err => stderr) do |data|
    puts data
  end

end
