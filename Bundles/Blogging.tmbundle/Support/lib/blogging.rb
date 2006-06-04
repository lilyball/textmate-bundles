require "#{ENV['TM_BUNDLE_SUPPORT']}/lib/textmate.rb"
require "#{ENV['TM_BUNDLE_SUPPORT']}/lib/keychain.rb"
require "#{ENV['TM_BUNDLE_SUPPORT']}/lib/metaweblog.rb"

$KCODE = 'u'

class Blogging
	DIVIDER = '✂------'
	BLOG_ACCOUNTS_FILE = File.expand_path("~/Library/Preferences/com.macromates.textmate.blogging.txt")

	# These elements are gathered from the environment; no need to explicitly
	# write to them.
	attr_reader :blog_id, :username, :host, :path, :mode, :headers, :publish

	# These elements can be assigned through public methods
	attr_writer :post_id, :post, :endpoint

	private

	def initialize
		at_exit { _finalize }
	end

	def _finalize
		if @mw_success
			# If an internet password was gathered during this process, and our
			# connection was successful, save it for the next request.
			_finally_save_internet_password if @save_password_on_success

			# If an endpoint was used for the first time during this command, and
			# the connection to it was successful, save it for the next request.
			_finally_save_new_endpoint if @save_endpoint_on_success
		end
	end

	def _finally_save_internet_password
		_proto = endpoint =~ /^https:/ ? 'https' : 'http'
		_path = path.clone
		_path.sub!(/#\d+/, '') if _path =~ /#\d+/
		KeyChain.add_internet_password(username, _proto, host, path, password)
	end

	def _finally_save_new_endpoint
		if File.exist?(BLOG_ACCOUNTS_FILE)
			_endpoints = IO.readlines(BLOG_ACCOUNTS_FILE)
		else
			_endpoints = [%Q{# Blogging Weblog List
# Enter a weblog name followed by the endpoint URL
# Weblog Name    URL
example          http://user@example.com/xmlrpc\n}]
		end
		_endpoints.push(endpoints[endpoint] + " " + endpoint + "\n")
		file = File.new(BLOG_ACCOUNTS_FILE, "w")
		file.write(_endpoints.join)
		file.close
	end

	def _find_internet_password
		_proto = endpoint =~ /^https:/ ? 'https' : 'http'
		_path = path.clone
		_path.sub!(/#\d+/, '') if _path =~ /#\d+/
		KeyChain.find_internet_password(username, _proto, host, _path)
	end

	def _fetch_credentials_from_keychain
		# we have @endpoint and possibly @username. fill in the blanks...
		if @username == nil
			@username = TextMate.standard_input_box("Blogging",
				"Enter the username to login at #{endpoint}")
			TextMate.exit_show_tool_tip("Cancelled") if username == nil
		end

		if @password == nil
			@password = _find_internet_password
			if @password == nil
				_endpoint = endpoint
				_endpoint.sub!(/#\d+/, '') if _endpoint =~ /#\d+/
				@password = TextMate.secure_standard_input_box("Blogging",
					"Enter the password to login at #{_endpoint}")
				TextMate.exit_show_tool_tip("Cancelled") if @password == nil
				@save_password_on_success = true
			end
		end
	end

	def _read_endpoints
		@endpoints = {}
		if File.exist?(BLOG_ACCOUNTS_FILE)
			IO.readlines(BLOG_ACCOUNTS_FILE).each do | _line |
				next if _line =~ /^\s*#/
				if _line =~ /^(.+?)\s+(https?:\/\/.+)/
					@endpoints[$1] = $2
					@endpoints[$2] = $1
				end
			end
		end
		return @endpoints
	end

	def _parse_endpoint
		# we have an endpoint that looks like a URL
		if @endpoint =~ /^https?:\/\//
			if endpoints[@endpoint]
				# The endpoint is a recognized URL; nothing else to do
			else
				# the endpoint is a URL but unrecognized... ask for a pretty name
				_name = TextMate.standard_input_box("Blogging",
					"Enter a name for this endpoint: #{@endpoint}")
				if _name != nil
					endpoints[_name] = @endpoint
					endpoints[@endpoint] = _name
					@save_endpoint_on_success = true
				else
					TextMate.exit_show_tool_tip("Cancelled")
				end
			end
		else
			if !endpoints[@endpoint]
				_url = TextMate.standard_input_box("Blogging",
					"Enter an endpoint URL for blog #{@endpoint}")
				if _url != nil
					endpoints[@endpoint] = _url
					endpoints[_url] = @endpoint
					@endpoint = _url
					@save_endpoint_on_success = true
				else
					TextMate.exit_show_tool_tip("Cancelled")
				end
			else
				# we had a named endpoint; swap with the URL...
				@endpoint = endpoints[@endpoint]
			end
		end

		# guess the mode based on the endpoint path
		@mode = ENV['TM_BLOG_MODE']
		if @mode == nil
			case @endpoint
			when %r{/mt-xmlrpc\.cgi}, %r{/backend/xmlrpc}
				@mode = 'mt'
			when %r{/xmlrpc\.php}
				@mode = 'wp'
			else
				# our default
				@mode = 'mt'
			end
		end

		if @endpoint =~ /^https?:\/\/([^\/]+?)(\/.+)$/
			@host = $1
			@path = $2
			if @host =~ /^(.+)(?:[:](.+))?@(.+)/
				@username = $1
				@password = $2
				@host = $3
			end
		else
			TextMate.exit_show_tool_tip("Error: invalid endpoint specified: #{@endpoint}")
		end

		if @endpoint =~ /#(\d+)/
			@blog_id = $1.to_i
		else
			@blog_id = 0
		end
	end

	def _parse_post
		_lines = STDIN.readlines

		@post = {}
		@headers = {}

		return if _lines.length == 0

		@post['mt_text_more'] = ''
		@post['description'] = ''
		@publish = true

		_in_headers = true
		_sep = false

		_lines.each do | _line |
			if _in_headers
				if _line =~ /^(\w+):[ ]*(.+)/
					case $1
					when 'Ping'
						@post['mt_tbping_urls'] = [] unless @post['mt_tbping_urls']
						@post['mt_tbping_urls'].push($2)
					when 'Category'
						@post['categories'] = [] unless @post['categories']
						@post['categories'].push($2)
					when 'Status'
						@publish = false if $2 =~ /draft/i
					end
					@headers[$1] = $2
					next
				else
					_in_headers = false
				end
			end
			if !_sep && (_line =~ %r{^(#{DIVIDER})+})
				_sep = true
				next
			end
			@post[ _sep ? 'mt_text_more' : 'description' ] += _line
		end

		@post['description'].strip!
		@post['mt_text_more'].strip!

		if (@post['mt_text_more'] == '') || (@post['mt_text_more'] == nil)
			@post.delete('mt_text_more')
		end
		@post['title'] = @headers['Title'] if @headers['Title']
		self.post_id = @headers['Post'].to_i if @headers['Post']

		_format = @headers['Format']
		post['mt_convert_breaks'] = _format if _format
		if !_format
			# we have to parse endpoint before
			# examining the mode variable, since it can be assigned by
			# the format of the endpoint url
			_endpoint = endpoint

			# scope-based sniffing of format; these are MT-specific.
			if mode == 'mt'
				case ENV['TM_SCOPE']
				when /markdown/
					post['mt_convert_breaks'] = 'markdown_with_smartypants'
				when /textile/
					post['mt_convert_breaks'] = 'textile_2'
				when /text\.blog\.html/
					post['mt_convert_breaks'] = '0'
				else
					post['mt_convert_breaks'] = '__default__'
				end
			end
		end

		_date_created = DateTime.parse(@headers['Date']) if @headers['Date']
		if mode == 'mt'
			@post['dateCreated'] = _date_created.strftime('%FT%T') if _date_created
			@post['mt_allow_comments'] = @headers['Comments'] =~ /\b(on|1|y(es)?)\b/i ? '1' : '0' if @headers['Comments']
			@post['mt_allow_pings'] = @headers['Pings'] =~ /\b(on|1|y(es)?)\b/i ? '1' : '0' if @headers['Pings']
			@post['mt_tags'] = @headers['Tags'] if @headers['Tags']
			@post['mt_basename'] = @headers['Basename'] if @headers['Basename']
		elsif mode == 'wp'
			@post['dateCreated'] = @dateCreated if @dateCreated
			@post['mt_allow_comments'] = @headers['Comments'] =~ /\b(on|1|y(es)?)\b/i ? 'open' : 'closed' if @headers['Comments']
			@post['mt_allow_pings'] = @headers['Pings'] =~ /\b(on|1|y(es)?)\b/i ? 'open' : 'closed' if @headers['Pings']
		end
		@post['mt_keywords'] = @headers['Keywords'] if @headers['Keywords']
	end

	public

	# Getters/Setters

	def password
		# The password can be embedded within the endpoint, so resolve
		# the endpoint first, which may set @password for us.
		_endpoint = endpoint
		_fetch_credentials_from_keychain unless @password
		return @password
	end

	def post
		_parse_post if @post == nil
		return @post
	end

	def post=(_post)
		@post = _post
		@post_id = post['postid'] if post['postid']
	end

	def post_id
		_parse_post if @post == nil
		return @post_id
	end

	def publish
		_parse_post if @post == nil
		return @publish
	end

	def headers
		_parse_post if @post == nil
		return @headers
	end

	def endpoint=(_endpoint)
		@endpoint = _endpoint
		_parse_endpoint
	end

	def endpoint
		return @endpoint if @endpoint != nil

		# Check the headers for a 'Blog' which is an endpoint
		if headers && headers['Blog']
			_endpoint = headers['Blog']
		end

		# Check TM_BLOG_ENDPOINT as a fallback
		if !_endpoint && ENV['TM_BLOG_ENDPOINT']
			_endpoint = ENV['TM_BLOG_ENDPOINT']
		end

		# Still no luck? Ask the user using endpoints in their config.
		if (_endpoint == nil)
			_endpoint = select_endpoint
			TextMate.exit_show_tool_tip("Cancelled") if _endpoint == nil
		end

		return self.endpoint = _endpoint
	end

	def endpoints
		_read_endpoints unless @endpoints
		return @endpoints
	end

	def client
		@client ||= MetaWeblogClient.new(@host, @path)
		return @client
	end

	# Utility methods

	def post_to_document
		_doc = ''
		_formats = {
			'textile_1' => 'Textile',
			'textile_2' => 'Textile',
			'markdown_with_smartypants' => 'Markdown',
			'markdown' => 'Markdown',
			'textile' => 'Textile',
			'Textile' => 'Textile',
			'Markdown' => 'Markdown',
			'__default__' => 'Text',
		}
		_format = 'HTML'
		if post['mt_convert_breaks']
			if _formats[post['mt_convert_breaks']]
				_format = _formats[post['mt_convert_breaks']]
			end
		end
		_blog = endpoints[endpoint] || endpoint
		_doc += "Type: Blog Post (#{_format})\n"
		_doc += "Blog: #{_blog}\n"
		_doc += "Post: #{post_id}\n"
		_doc += "Title: #{post['title']}\n"
		_doc += "Keywords: #{post['keywords']}\n" if post['keywords']
		_doc += "Tags: #{post['mt_tags']}\n" if post['mt_tags'] && (post['mt_tags'] != '')
		if (mode == 'wp') && post['category']
			_cats = post['category'].split(/,/)
			_cats.each { | _cat | _doc += "Category: #{_cat}\n" }
		end
		_doc += "Format: #{post['mt_convert_breaks']}\n" if post['mt_convert_breaks']
		_doc += sprintf "Date: %04d-%02d-%02d %02d:%02d:%02d\n",
		 	post['dateCreated'].year,
			post['dateCreated'].month,
			post['dateCreated'].day,
			post['dateCreated'].hour,
			post['dateCreated'].min,
			post['dateCreated'].sec
		if post['mt_allow_pings'] && (post['mt_allow_pings'] == 1)
			_doc += "Pings: On\n"
		else
			_doc += "Pings: Off\n"
		end
		if post['mt_allow_comments'] && (post['mt_allow_comments'] == 1)
			_doc += "Comments: On\n"
		else
			_doc += "Comments: Off\n"
		end
		_doc += "Basename: " + post['mt_basename'] + "\n" if post['mt_basename']
		if post['categories']
			post['categories'].each do | _cat |
				_doc += "Category: #{_cat}\n"
			end
		end
		_doc += "\n"
		_doc += post['description'] + "\n"
		if post['mt_text_more'] && (post['mt_text_more'] != '')
			_doc += "\n#{DIVIDER * 10}\n\n"
			_doc += post['mt_text_more'] + "\n"
		end
		return _doc
	end

	def request_title(default)
		s = TextMate.inputbox(%Q{--title 'Title of Post' \
			--informative-text 'Enter a title for this post.' \
			--text "#{default.gsub(/"/,'\"')}" \
			--button1 'Post' --button2 'Cancel'})
		case (a = s.split(/\n/))[0].to_i
			when 1: return "#{a[1]}"
			when 2: TextMate.exit_show_tool_tip("Cancelled")
		end
	end

	def show_post_page
		begin
			_password = password
			self.post = client.getPost(post_id, username, _password)
			if publish
				link = post['permaLink']
				%x{open "#{link}"} if link
			end
			@mw_success = true
		rescue XMLRPC::FaultException => e
			# ignore for now?
		end
	end

	def select_post(_posts)
		_titles = []
	 	_posts.each { |_p| _titles.push( '"' + _p['title'].gsub(/"/, '\"') + '"' ) }

		_result = TextMate.dropdown(%Q{--title 'Select Blog' \
			--text 'Fetch Post' \
			--button1 Load --button2 Cancel \
			--items #{_titles.join(' ')}})

		_result = _result.split(/\n/)
		if _result[0] == "1"
			return _posts[_result[1].to_i]
		end
		return nil
	end

	def select_endpoint
		if endpoints.length == 2
			# there's only one endpoint here (we store two keys for each)
			# return the first one
			endpoints.each_key do | _name |
				return _name if _name !~ /^https?:/
				return endpoints[_name]
			end
		end

		_titles = []
		endpoints.each_key do | _name |
			next if _name =~ /^https?:/
			_titles.push( '"' + _name.gsub(/"/, '\"') + '"' )
		end

		if _titles.length == 0
			TextMate.exit_show_tool_tip("No blog accounts are configured.\nPlease see Help or run Setup Blogs command.")
		end

		_titles.sort!
		_result = TextMate.dropdown(%Q{--title 'Select Blog' \
			--text 'Choose a blog' \
			--button1 Ok --button2 Cancel \
			--items #{_titles.join(' ')}})

		_result = _result.split(/\n/)
		if _result[0] == "1"
			_name = _titles[_result[1].to_i].gsub(/^"|"$/, '')
			return endpoints[_name]
		end
		return nil
	end

	# Command: Post

	def post_or_update
		if !post['title']
			_filename = ENV['TM_FILENAME'] || ''
			_filename.sub!(/\.[a-z]+$/, '') if _filename
			post['title'] = request_title(_filename)
		end

		begin
			_password = password
			if post_id
				result = client.editPost(post_id, username, _password, post, publish)
			else
				self.post_id = client.newPost(blog_id, username, _password, post, publish)
			end
			show_post_page
			@mw_success = true
			TextMate.exit_replace_document(post_to_document)
		rescue XMLRPC::FaultException => e
			TextMate.exit_show_tool_tip("Error: #{e.faultString} (#{e.faultCode})")
		end
	end

	# Command: Fetch

	def fetch
		begin
			# Makes sure endpoint is determined and elements are parsed
			_password = password
			_result = client.getRecentPosts(blog_id, username, _password, 20)
			if !_result.length
				TextMate.exit_show_tool_tip("No posts are available!")
			end
			@mw_success = true
			if self.post = select_post(_result)
				TextMate.exit_create_new_document(post_to_document)
			end
		rescue XMLRPC::FaultException => e
			TextMate.exit_show_tool_tip("Error retrieving posts. Check your configuration and try again.")
		end
	end

	# Command: View

	def view
		if post_id
			show_post_page
		else
			TextMate.exit_show_tool_tip("A Post ID is required to view the post.")
		end
	end

	# 'blog' Command (snippet)

	def choose_blog_endpoint
		if endpoints.length == 2
			_endpoint = nil
			endpoints.each_key do | _name |
				if _name !~ /^https?:/
					_endpoint = _name
				else
					_endpoint = endpoints[_name]
				end
				break
			end
			TextMate.exit_insert_snippet("Blog: #{_endpoint}")
		end

		_titles = []
		endpoints.each_key do | _name |
			next if _name =~ /^https?:/
			_titles.push( '"' + _name.gsub(/"/, '\"') + '"' )
		end
		_titles.sort!

		_result = TextMate.dropdown(%Q{--title 'Select Blog' \
			--text 'Choose a blog' \
	  	--button1 Ok --button2 Cancel \
	  	--items #{_titles.join(' ')}})

		_result = _result.split(/\n/)

		if _result[0] == "1"
			TextMate.exit_insert_snippet("Blog: " +
				_titles[_result[1].to_i].gsub(/^"|"$/, '') + '$0')
		end
		TextMate.exit_show_tool_tip(%Q{No weblogs have been configured.\n} +
			%q{Use the "Setup Blogs" command."})
	end

end