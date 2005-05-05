require 'English' # you are angry, english!

svn				= ENV['TM_SVN']
#commit_paths	= ENV['CommitPaths']
commit_tool		= ENV['CommitWindow']
bundle			= ENV['TM_BUNDLE_PATH']

CURRENT_DIR		= Dir.pwd + "/"

require (bundle + '/Tools/shelltokenize.rb')

puts "<html>
<head>
<title>Subversion status</title>
<style type=\"text/css\">
  @import 'file://#{bundle}/Stylesheets/svn_style.css';
</style>
</head>

<body>"

puts "<h1>Subversion Commit</h1>"
puts "<hr>"

# Ignore files without changes
#puts TextMate::selected_paths_for_shell
status_command = %Q{"#{svn}" status #{TextMate::selected_paths_for_shell}}
#puts status_command
status_output = %x{#{status_command}}
#puts status_output
paths = status_output.scan(/^(.)....(\s+)(.*)\n/)


def matches_to_paths(matches)
	paths = matches.collect {|m| m[2] }
	paths.collect{|path| path.sub(/^#{CURRENT_DIR}/, "") }
end

# Ignore files with '?', but report them to the user
unknown_paths = paths.select { |m| m[0] == '?' }

if unknown_paths and unknown_paths.size > 0 then
	puts "These files are not added to the repository, and so will not be committed:<p><ul><li>#{matches_to_paths(unknown_paths).join("</li><li>")}</li></ul><p>"
end

# Fail if we have conflicts -- svn commit will fail, so let's
# error out before the user gets too involved in the commit
conflict_paths = paths.select { |m| m[0] == 'C' }

if conflict_paths and conflict_paths.size > 0 then
	puts "Cannot continue; there are merge conflicts in files:<p><ul><li>#{matches_to_paths(conflict_paths).join("</li><li>")}</li></ul><p>"
	puts "Canceled."
	exit -1
end

# Remove the unknown paths from the commit
commit_matches = paths - unknown_paths

if commit_matches.nil? or commit_matches.size == 0
	puts "File(s) not modified; nothing to commit."
	exit 0
end

STDOUT.flush

commit_paths_array = matches_to_paths(commit_matches)

commit_path_text = commit_paths_array.collect{|path| path.quote_filename_for_shell }.join(" ")

#puts commit_path_text
commit_args = %x{"#{commit_tool}" #{commit_path_text}}

status = $CHILD_STATUS
if status != 0
	puts "Canceled (#{status >> 8})."
	exit -1
end

puts "<div class=\"command\">"
puts %Q{<strong>#{svn} commit </strong>#{commit_args.gsub("' '", "'<br>'").gsub("'\"'\"'", "'")}}
puts "</div>"
puts "<p> <pre>"
STDOUT.flush

fork { exec "#{svn} commit #{commit_args}" }
Process.wait

puts "</pre></body></html>"
