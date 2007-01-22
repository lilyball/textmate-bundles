require "#{ENV["TM_BUNDLE_SUPPORT"]}/helper"

dir = ENV['TM_PROJECT_DIRECTORY']
prj_path = ENV['TM_PROJECT_FILEPATH']
if dir == nil or prj_path == nil
	dir = ENV['TM_DIRECTORY']
	prj_path = ENV['TM_FILEPATH']
end
if dir == nil or prj_path == nil
	html_header('Make Current Project')
	puts('<p>Error: Project not found.</p>')
else
	prj_name = File.basename(prj_path)
	html_header("Make “#{prj_name}”")
	Dir.chdir(dir)
	make(dir)
end
html_footer()
