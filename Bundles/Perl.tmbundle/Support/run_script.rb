require "#{ENV["TM_SUPPORT_PATH"]}/lib/escape"
require 'open3'
require 'fcntl'

@content = STDIN.read

if ENV.has_key? 'TM_FILEPATH' then
	@path = ENV['TM_FILEPATH']
	# if file was not saved let's pipe our source via STDIN
	open(@path, "r") { |io|
	  if (io.read != @content)
	    @path = ''
	  end
	}
else
	@path = ''
end
rd, wr = IO.pipe
rd.fcntl(Fcntl::F_SETFD, 1)
ENV['TM_ERROR_FD'] = wr.to_i.to_s
@perl = @arg0 || ENV['TM_PERL'] || 'perl'
args = [ @perl, Array(@args), @path, ARGV.to_a ].flatten
stdin, stdout, stderr = Open3.popen3(*args)
Thread.new { stdin.write @content; stdin.close } if @path == ''
wr.close

err = stderr.read
if (err)
  print "<span style='color: red'>#{htmlize err}</span>"
end
print htmlize(stdout.read)
