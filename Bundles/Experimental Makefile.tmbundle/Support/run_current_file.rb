require "#{ENV["TM_BUNDLE_SUPPORT"]}/helper"

dir = ENV['TM_DIRECTORY']
file_path = ENV['TM_FILEPATH']
if dir == nil or file_path == nil
	html_header('Run Current File')
	puts('<p>Error: File not found.</p>')
else
	file_name = File.basename(file_path)
	file_ext = File.extname(file_path)
	exec_name = file_name.sub(/#{e_sh(file_ext)}$/, '.x')
	html_header("Run “#{file_name}”")
	Dir.chdir(dir)
	compile(dir, get_compiler(file_ext), [file_name], exec_name)
	run(dir, exec_name)
	# Dir['dat/*.in'].each do |in_file_name|
	# 	test(dir, exec_name, in_file_name)
	# end
end
html_footer()
