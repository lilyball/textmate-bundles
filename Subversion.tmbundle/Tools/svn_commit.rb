require 'English'
# you are angry, english!

svn				= ENV['TM_SVN']
commit_paths	= ENV['CommitPaths']
commit_tool		= ENV['CommitWindow']
bundle			= ENV['TM_BUNDLE_PATH']


puts "<html>
<head>
<title>Subversion status</title>
<style type=\"text/css\">
  @import 'file://"+bundle+"/Stylesheets/svn_style.css';
</style>
</head>

<body>"

puts "<h1>Subversion Commit</h1>"
puts "<hr>"

# Ignore files without changes
status_output = %x{"#{svn}" status #{commit_paths}}

paths = status_output.scan(/^(.)....(\s+)(.*)\n/)


def matches_to_paths(matches)
	matches.collect {|m| m[2] }
end

# Ignore files with '?', but report them to the user
unknown_paths = paths.reject { |m| m[0] != '?' }

if unknown_paths and unknown_paths.size > 0 then
	puts "These files are not added to the repository, and so will not be committed:<p><ul><li>#{matches_to_paths(unknown_paths).join("</li><li>")}</li></ul><p>"
end

# Fail if we have conflicts -- svn commit will fail, so let's
# error out before the user gets too involved in the commit
conflict_paths = paths.reject { |m| m[0] != 'C' }

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

# Nuke unnecessary bits of the path
current_dir = Dir.pwd + "/"
commit_paths_array.collect!{|path| path.sub(/^#{current_dir}/, "") }

commit_path_text = "'" + commit_paths_array.join("' '") + "'"

commit_args = %x{"#{commit_tool}" #{commit_path_text}}

status = $CHILD_STATUS
if status != 0
	puts "Canceled (#{status})."
	exit -1
end

puts "<div class=\"command\">"
puts %Q{<strong>#{svn} commit </strong>#{commit_args.gsub("' '", "'<br>'").gsub("'\"'\"'", "'")}}
puts "</div>"
puts "<p> <pre>"
STDOUT.flush

puts %x{"#{svn}" commit #{commit_args}}

puts "</pre></body></html>"
