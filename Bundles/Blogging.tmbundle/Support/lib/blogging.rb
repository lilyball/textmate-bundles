require 'date'

$KCODE = 'u'

# Man, these should be in SharedSupport/Support/lib/textmate.rb !!

def exit_discard; exit 200 end
def exit_replace_text; exit 201; end
def exit_replace_document; exit 202 end
def exit_insert_text; exit 203 end
def exit_insert_snippet; exit 204 end
def exit_show_html; exit 205 end
def exit_show_tool_tip; exit 206 end
def exit_create_new_document; exit 207 end

def find_internet_password
	proto = $endpoint.match(/^https/) ? 'https' : 'http'
	path = $path.clone
	path.sub!(/#\d+/, '') if path.match(/#\d+/)
	result = %x{security find-internet-password -g -a "#{$username}" -s "#{$host}" -p "#{path}" -r #{proto} 2>&1 >/dev/null}
	if (result.match(/^password: "(.*)"$/))
		return $1
	end
	return nil
end

def save_internet_password
	proto = $endpoint.match(/^https/) ? 'https' : 'http'
	%x{security add-internet-password -a "#{$username}" -s "#{$host}" -r "#{proto}" -p "#{$path}" -w "#{$password}" 2>/dev/null}
end

def standard_input_box(prompt)
	result = %x{"#{ENV['TM_SUPPORT_PATH']}/bin/CocoaDialog.app/Contents/MacOS/CocoaDialog" standard-inputbox --title 'Blogging' --informative-text "#{prompt.gsub(/"/, "\\\"")}"}
	result = result.split(/\n/)
	if (result[0] == '1')
		return result[1]
	end
	return nil
end

def secure_input_box(prompt)
	result = %x{"#{ENV['TM_SUPPORT_PATH']}/bin/CocoaDialog.app/Contents/MacOS/CocoaDialog" secure-standard-inputbox --title 'Blogging' --informative-text "#{prompt.gsub(/"/, "\\\"")}"}
	result = result.split(/\n/)
	if (result[0] == '1')
		return result[1]
	end
	return nil
end

def fetch_credentials_from_keychain
	# we have $endpoint and possibly $username. fill in the blanks...
	if ($username == nil)
		$username = standard_input_box("Enter the username to login at  #{$endpoint}")
		if ($username == nil)
			print "Cancelled"
			exit_show_tool_tip
		end
	end

	if ($password == nil)
		$password = find_internet_password

		if ($password == nil)
			$password = standard_input_box("Enter the password to login at  #{$endpoint}")
			if ($password == nil)
				print "Cancelled"
				exit_show_tool_tip
			else
				$save_password_on_success = 1
			end
		end
	end
end

def parse_endpoint(str)
	$endpoint = str.clone

	mode = nil
	if ($endpoint.match(/mt-xmlrpc/))
		mode = 'mt'
	elsif ($endpoint.match(/xmlrpc\.php/))
		mode = 'wp'
	else
		mode = ENV['TM_BLOG_MODE'] || 'mt'
	end
	$mode = mode

	if (match = $endpoint.match(/^https?:\/\/([^\/]+?)(\/.+)$/))
		$host = match[1]
		$path = match[2]
		if (match = $host.match(/^(.+)(?:[:](.+))?@(.+)/))
			$username = match[1]
			$password = match[2]
			$host = match[3]
		end
	else
		print "Error: invalid endpoint specified: #{$endpoint}"
		exit_show_tool_tip
	end

	if ($endpoint.match(/#(\d+)/))
		$blog_id = $1.to_i
	end
end

def init
	$username = nil
	$password = nil
	$blog_id = nil

	if (ENV['TM_BLOG_ENDPOINT'])
		parse_endpoint(ENV['TM_BLOG_ENDPOINT'])
	end
	$format = ENV['TM_BLOG_FORMAT']

	if (!$endpoint)
		print "Setup required. Please see Help."
		exit_show_tool_tip
	end
end

# Post/Update

def request_title(default)
	s = `\"#{ENV['TM_SUPPORT_PATH']}/bin/CocoaDialog.app/Contents/MacOS/CocoaDialog\" inputbox --title 'Title of Post' --informative-text 'Enter a title for this post.' --text "#{default.gsub(/"/,'\"')}" --button1 'Post' --button2 'Cancel'`
	case (a = s.split(/\n/))[0].to_i
		when 1: (a[1])
		when 2: print "Post cancelled."; exit_show_tool_tip
	end
end

def post_parse(lines)
	post = {}
	headers = {}
	post['mt_text_more'] = ''
	post['description'] = ''
	post['mt_tbping_urls'] = []
	post['categories'] = []
	post['publish'] = true

	content = ''
	in_headers = TRUE
	sep = FALSE
	lastLine = nil

	lines.each do | line |
		if (in_headers)
			if (matches = line.match(/^(\w+):[ ]*(.+)/))
				if (matches[1] == 'Ping')
					post['mt_tbping_urls'].push(matches[2])
				elsif (matches[1] == 'Category')
					post['categories'].push(matches[2])
				elsif (matches[1] == 'Status')
					post['publish'] = FALSE if matches[2].match(/draft/i)
				elsif (matches[1] == 'Blog')
					parse_endpoint(matches[2])
				else
					headers[matches[1]] = matches[2]
				end
				next
			else
				in_headers = FALSE
			end
		end
		if (!sep && (/^---+$/ =~ line) && lastLine && (lastLine == "\n"))
			sep = TRUE
			next
		end
		post[ sep ? 'mt_text_more' : 'description' ] += line
		lastLine = line
	end

	post['description'] = post['description'].strip!
	post['mt_text_more'] = post['mt_text_more'].strip!
	if ((post['mt_text_more'] == '') || (post['mt_text_more'] == nil))
		post.delete('mt_text_more')
	end
	post['title'] = headers['Title'] if headers['Title']
	post['id'] = headers['Post'].to_i if headers['Post']
	format = headers['Format'] || $format
	post['mt_convert_breaks'] = format if format
	if (!format)
		# scope-based sniffing of format; these are MT-specific.
		if ($mode == 'mt')
			if (/markdown/ =~ ENV['TM_SCOPE'])
				post['mt_convert_breaks'] = 'markdown_with_smartypants'
			elsif (/textile/ =~ ENV['TM_SCOPE'])
				post['mt_convert_breaks'] = 'textile_2'
			end
		end
	end
	dateCreated = DateTime.parse(headers['Date']) if headers['Date']
	post['dateCreated'] = dateCreated if dateCreated
	if ($mode == 'mt')
		post['mt_allow_comments'] = headers['Comments'] =~ /\b(on|1|y(es)?)\b/i ? '1' : '0' if headers['Comments']
		post['mt_allow_pings'] = headers['Pings'] =~ /\b(on|1|y(es)?)\b/i ? '1' : '0' if headers['Pings']
	elsif ($mode == 'wp')
		post['mt_allow_comments'] = headers['Comments'] =~ /\b(on|1|y(es)?)\b/i ? 'open' : 'closed' if headers['Comments']
		post['mt_allow_pings'] = headers['Pings'] =~ /\b(on|1|y(es)?)\b/i ? 'open' : 'closed' if headers['Pings']
	end
	post['mt_keywords'] = headers['Keywords'] if headers['Keywords']
	post['mt_tags'] = headers['Tags'] if headers['Tags']
	post['mt_basename'] = headers['Basename'] if headers['Basename']
	return post
end

def show_post_page(post_id)
	require 'xmlrpc/client'

	begin
		server = XMLRPC::Client.new($host, $path)
		result = server.call("metaWeblog.getPost", post_id, $username, $password)
		link = result['permaLink']
		%x{open "#{link}"} if link
	rescue XMLRPC::FaultException => e
		# ignore for now?
	end
end

def post_or_update
	require 'xmlrpc/client'

	doc = STDIN.readlines

	filename = ENV['TM_FILENAME'] || ''
	if (filename)
		filename = filename.sub(/\.[a-z]+$/, '')
	end

	post_id = nil
	post = post_parse(doc)

	if (post['id'])
		post_id = post['id']
		post.delete('id')
	end

	if (!post['title'])
		post['title'] = request_title(filename)
	end

	publish = post['publish']
	post.delete('publish')

	begin
		fetch_credentials_from_keychain
		server = XMLRPC::Client.new($host, $path)
		if (post_id)
			result = server.call("metaWeblog.editPost",
				post_id, $username, $password, post, publish)
			if ($save_password_on_success)
				save_internet_password
			end
			show_post_page(post_id) if publish
			print "Updated!"
		else
			result = server.call("metaWeblog.newPost",
				$blog_id, $username, $password, post, publish)
			if ($save_password_on_success)
				save_internet_password
			end
			post_id = result
			show_post_page(post_id) if publish
			print "Post: #{post_id}\n"
			doc.each { | line | print line }
			exit_replace_document
		end
	rescue XMLRPC::FaultException => e
		print "Error: #{e.faultString} (#{e.faultCode})"
	end
	exit_show_tool_tip
end

# Fetch Post

def select_post(posts)
	post_titles = []
 	posts.each { |p| post_titles.push( '"' + p['title'].gsub(/"/, '\"') + '"' ) }

	result = %x{"#{ENV['TM_SUPPORT_PATH']}/bin/CocoaDialog.app/Contents/MacOS/CocoaDialog"  dropdown \
    --title 'Fetch Post' \
    --text 'Choose a post to edit' \
    --button1 Load --button2 Cancel \
    --items #{post_titles.join(' ')}}

	result = result.split(/\n/)

	if result[0] == "1"
		return posts[result[1].to_i]
	end
	return nil
end

def return_post(post)
	formats = {
		'textile_1' => 'Textile',
		'textile_2' => 'Textile',
		'markdown_with_smartypants' => 'Markdown',
		'markdown' => 'Markdown',
		'textile' => 'Textile',
		'Textile' => 'Textile',
		'Markdown' => 'Markdown',
		'__default__' => 'Text',
	}
	format = 'HTML'
	if (post['mt_convert_breaks'])
		if (formats[post['mt_convert_breaks']])
			format = formats[post['mt_convert_breaks']]
		end
	end
	print "Type: Blog Post (#{format})\n"
	print "Blog: #{$endpoint}\n"
	print "Post: " + post['postid'] + "\n"
	print "Title: " + post['title'] + "\n"
	print "Keywords: " + post['keywords'] + "\n" if post['keywords']
	print "Tags: " + post['mt_tags'] + "\n" if post['mt_tags'] && (post['mt_tags'] != '')
	if (($mode == 'wp') && (post['category']))
		cats = post['category'].split(/,/)
		cats.each { | cat | print "Category: #{cat}\n" }
	end
	print "Format: " + post['mt_convert_breaks'] + "\n" if post['mt_convert_breaks']
	printf "Date: %04d-%02d-%02d %02d:%02d:%02d\n", post['dateCreated'].year, post['dateCreated'].month, post['dateCreated'].day, post['dateCreated'].hour, post['dateCreated'].min, post['dateCreated'].sec
	if (post['mt_allow_pings'] && (post['mt_allow_pings'] == 1))
		print "Pings: On\n"
	else
		print "Pings: Off\n"
	end
	if (post['mt_allow_comments'] && (post['mt_allow_comments'] == 1))
		print "Comments: On\n"
	else
		print "Comments: Off\n"
	end
	print "Basename: " + post['mt_basename'] + "\n" if post['mt_basename']
	if (post['categories'])
		post['categories'].each do | cat |
			print "Category: #{cat}\n"
		end
	end
	print "\n"
	print post['description'] + "\n"
	if ((post['mt_text_more']) && (post['mt_text_more'] != ''))
		print "\n------------------------------------\n\n"
		print post['mt_text_more'] + "\n"
	end
end

def fetch_post
	require 'xmlrpc/client'

	server = XMLRPC::Client.new($host, $path)
	begin
		fetch_credentials_from_keychain
		$blog_id = 0 if !$blog_id
		result = server.call("metaWeblog.getRecentPosts",
			$blog_id, $username, $password, 20)
		if ($save_password_on_success)
			save_internet_password
		end
		if (!result.length)
			print "Error: No posts available!"
			exit_show_tool_tip
		end
		if (selection = select_post(result))
			return_post(selection)
			exit_create_new_document
		end
	rescue XMLRPC::FaultException => e
		print "Error retrieving posts. Check your configuration and try again."
		exit_show_tool_tip
	end
end

# Preview

def preview_post
	require 'FileTest'

	blog_preview = nil
	if ($blog_id)
		blog_preview = "#{ENV['TM_BUNDLE_PATH']}/Templates/Preview Template/preview_#{$blog_id}.txt"
	end

	default_preview = "#{ENV['TM_BUNDLE_PATH']}/Templates/Preview Template/preview.txt"

	if (blog_preview && (File.exist?(blog_preview)))
		preview_file = blog_preview
	elsif (File.exist?(default_preview))
		preview_file = default_preview
	else
		print "Couldn't find preview template!"
	end
	input = IO.readlines(preview_file)
	post = post_parse(doc)
end

def view_post
	post = post_parse(STDIN.readlines)
	if (post['id'])
		fetch_credentials_from_keychain
		show_post_page(post['id'])
		exit_discard
	else
		print "A Post ID is required to view the post."
		exit_show_tool_tip
	end
end

init