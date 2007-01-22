require "#{ENV["TM_SUPPORT_PATH"]}/lib/escape"
require "#{ENV["TM_SUPPORT_PATH"]}/lib/web_preview"
require "#{ENV["TM_SUPPORT_PATH"]}/lib/tm_parser"

def htmlize(string)
	string.to_s.gsub(/`(.*?)'/, '‘\1’').gsub('&', '&amp;').gsub('<', '&lt;')
end

def link(file_path, line_number = nil)
	string = "<a href=\"txmt://open?url=file://#{e_url(file_path)}"
	string += "&amp;line=#{line_number}" unless line_number.nil?
	string += "\" title=\"#{file_path}\">#{htmlize(File.basename(file_path))}"
	string += ":#{line_number}" unless line_number.nil?
	string += "</a>"
end

def parse_errors(dir, text)
	print('<pre>')
	state = :cmd_block
	state_data = nil
	text.each_line do |line|
		line = line.chop()
		if m = /^(In file included from )(.*?)(?::(\d+))?((?:,|:).*?)$/.match(line)
			head, file_name, line_number, tail = m[1..4]
			print('</pre><pre>')
			state = :include_block
			file_path = File.expand_path(file_name, dir)
			if File.exists?(file_path)
				print(head + link(file_path, line_number) + tail + '<br>')
			else
				print(htmlize(line) + '<br>')
			end
		elsif m = /^(\s*from )(.*?)(?::(\d+))?((?:,|:).*?)$/.match(line)
			head, file_name, line_number, tail = m[1..4]
			if state != :include_block
				print('</pre><pre>')
			end
			state = :include_block
			file_path = File.expand_path(file_name, dir)
			if File.exists?(file_path)
				print(head + link(file_path, line_number) + tail + '<br>')
			else
				print(htmlize(line) + '<br>')
			end
		elsif m = /^(.*?)(: (?:In|At).*?)$/.match(line)
			file_name, tail = m[1..2]
			print('</pre><pre>')
			state = :function_block
			state_data = file_name
			file_path = File.expand_path(file_name, dir)
			if File.exists?(file_path)
				print(link(file_path) + tail + '<br>')
			else
				print(htmlize(line) + '<br>')
			end
		elsif m = /^(.*?)(?::(\d+))?(:.*?)$/.match(line)
			file_name, line_number, tail = m[1..3]
			if (!(((state == :file_block or state == :function_block) and state_data == file_name) or state == :include_block))
				print('</pre><pre>')
			end
			state = :file_block
			state_data = file_name
			file_path = File.expand_path(file_name, dir)
			if File.exists?(file_path)
				print(link(file_path, line_number) + tail + '<br>')
			else
				print(htmlize(line) + '<br>')
			end
		else
			if state != :cmd_block
				print('</pre><pre>')
			end
			state = :cmd_block
			print(htmlize(line) + '<br>')
		end
	end
	print('</pre>')
end

def get_compiler(file_ext)
	case file_ext
	when /\.c(c|pp?|xx?|\+\+?)/, '.C', '.ii'
		'g++'
	else
		'gcc'
	end
end

def compile(dir, compiler, file_names, exec_name)
	gcc_flags = ENV['TM_GCC_FLAGS']
	if gcc_flags == nil
		gcc_flags = "-Wall -Os"
	end
	cmd = "#{compiler} #{gcc_flags}"
	file_names.each do |file_name|
		cmd += " #{file_name}"
	end
	cmd += " -o #{exec_name}"
	parse_errors(dir, cmd + "\n" + `#{cmd} 2>&1`)
end

def run(dir, exec_name)
	cmd = "./#{exec_name}"
	parse_errors(dir, cmd + "\n" + `#{cmd} 2>&1`)
end

# def test(dir, exec_name, in_file_name)
# 	out_file_name = in_file_name.sub(/.in$/, '.out')
# 	cmd = "(time ./#{exec_name} < #{in_file_name}) | diff /dev/stdin #{out_file_name}"
# 	parse_errors(dir, cmd + "\n" + `(#{cmd}) 2>&1 | tail -n +2`)
# end

def make(dir, target = nil)
	make_flags = ENV['TM_MAKE_FLAGS']
	cmd = "make #{make_flags}"
	if target
		cmd += " #{target}"
	end
	parse_errors(dir, cmd + "\n" + `#{cmd} 2>&1`)
end
