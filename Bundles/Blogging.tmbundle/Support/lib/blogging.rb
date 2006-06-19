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
    at_exit { finalize() }
  end

  def finalize
    if @mw_success
      # If an internet password was gathered during this process, and our
      # connection was successful, save it for the next request.
      finally_save_internet_password() if @save_password_on_success

      # If an endpoint was used for the first time during this command, and
      # the connection to it was successful, save it for the next request.
      finally_save_new_endpoint() if @save_endpoint_on_success
    end
  end

  def finally_save_internet_password
    protocol = self.endpoint =~ /^https:/ ? 'https' : 'http'
    endpoint_path = self.path.clone
    endpoint_path.sub!(/#\d+/, '') if endpoint_path =~ /#\d+/
    KeyChain.add_internet_password(self.username, protocol, self.host,
      endpoint_path, self.password)
  end

  def finally_save_new_endpoint
    if File.exist?(BLOG_ACCOUNTS_FILE)
      endpoint_list = IO.readlines(BLOG_ACCOUNTS_FILE)
    else
      endpoint_list = [ <<-TEXT ]
# Blogging Account List
# Enter a blog name followed by the endpoint URL
# Blog Name      URL
# example        http://user@example.com/xmlrpc
TEXT
    end
    endpoint_list.push(self.endpoints[self.endpoint] + " " + self.endpoint +
      "\n")
    File.open(BLOG_ACCOUNTS_FILE, "w") do | file |
      file.write(endpoint_list.join)
    end
  end

  def find_internet_password
    protocol = self.endpoint =~ /^https:/ ? 'https' : 'http'
    endpoint_path = self.path.clone
    endpoint_path.sub!(/#\d+/, '') if endpoint_path =~ /#\d+/
    KeyChain.find_internet_password(self.username, protocol, self.host,
      endpoint_path)
  end

  def fetch_credentials_from_keychain
    # we have @endpoint and possibly @username. fill in the blanks...
    if @username == nil
      @username = TextMate.standard_input_box("Blogging",
        "Enter the username to login at #{self.endpoint}")
      TextMate.exit_discard if self.username == nil
    end

    if @password == nil
      @password = find_internet_password()
      if @password == nil
        current_endpoint = self.endpoint
        current_endpoint.sub!(/#\d+/, '') if current_endpoint =~ /#\d+/
        @password = TextMate.secure_standard_input_box("Blogging",
          "Enter the password to login at #{current_endpoint}")
        TextMate.exit_discard if @password == nil
        @save_password_on_success = true
      end
    end
  end

  def read_endpoints
    @endpoints = {}
    if File.exist?(BLOG_ACCOUNTS_FILE)
      IO.readlines(BLOG_ACCOUNTS_FILE).each do | line |
        next if line =~ /^\s*#/
        if line =~ /^(.+?)\s+(https?:\/\/.+)/
          @endpoints[$1] = $2
          @endpoints[$2] = $1
        end
      end
    end
    @endpoints
  end

  def parse_endpoint
    # we have an endpoint that looks like a URL
    if @endpoint =~ /^https?:\/\//
      if self.endpoints[@endpoint]
        # The endpoint is a recognized URL; nothing else to do
      else
        # the endpoint is a URL but unrecognized... ask for a pretty name
        name = TextMate.standard_input_box("Blogging",
          "Enter a name for this endpoint: #{@endpoint}")
        if name != nil
          self.endpoints[name] = @endpoint
          self.endpoints[@endpoint] = name
          @save_endpoint_on_success = true
        else
          TextMate.exit_discard
        end
      end
    else
      if !self.endpoints[@endpoint]
        url = TextMate.standard_input_box("Blogging",
          "Enter an endpoint URL for blog #{@endpoint}")
        if url != nil
          self.endpoints[@endpoint] = url
          self.endpoints[url] = @endpoint
          @endpoint = url
          @save_endpoint_on_success = true
        else
          TextMate.exit_discard
        end
      else
        # we had a named endpoint; swap with the URL...
        @endpoint = self.endpoints[@endpoint]
      end
    end

    # guess the mode based on the endpoint path
    @mode = ENV['TM_BLOG_MODE']
    if @mode == nil
      case @endpoint
      when %r{/mt-xmlrpc\.cgi}, %r{/backend/xmlrpc}
        @mode = 'mt'
      when %r{/xmlrpc(\.php)?}
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

  def parse_post
    lines = STDIN.readlines

    @post = {}
    @headers = {}

    return if lines.length == 0

    @post['mt_text_more'] = ''
    @post['description'] = ''
    @publish = true

    in_headers = true
    separator = false

    lines.each do | line |
      if in_headers
        if line =~ /^(\w+):[ ]*(.+)/
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
          in_headers = false
        end
      end
      if line =~ %r{^(#{DIVIDER})+}
        if !separator
          separator = true
          next
        else
          # establish endpoint, which sets mode
          current_endpoint = self.endpoint
          if self.mode == 'wp'
            line = '<!--more-->'
          end
        end
      end
      @post[ separator ? 'mt_text_more' : 'description' ] += line
    end

    @post['description'].strip!
    @post['mt_text_more'].strip!

    if (@post['mt_text_more'] == '') || (@post['mt_text_more'] == nil)
      @post.delete('mt_text_more')
    else
      @post['description'] += "\n\n"
    end
    @post['title'] = @headers['Title'] if @headers['Title']
    self.post_id = @headers['Post'].to_i if @headers['Post']

    format = @headers['Format']
    self.post['mt_convert_breaks'] = format if format
    if !format
      # we have to parse endpoint before
      # examining the mode variable, since it can be assigned by
      # the format of the endpoint url
      current_endpoint = self.endpoint

      # scope-based sniffing of format; these are MT-specific.
      if self.mode == 'mt'
        case ENV['TM_SCOPE']
        when /markdown/
          self.post['mt_convert_breaks'] = 'markdown_with_smartypants'
        when /textile/
          self.post['mt_convert_breaks'] = 'textile_2'
        when /text\.blog\.html/
          self.post['mt_convert_breaks'] = '0'
        else
          self.post['mt_convert_breaks'] = '__default__'
        end
      end
    end

    date_created = DateTime.parse(@headers['Date']) if @headers['Date']
    if self.mode == 'mt'
      @post['dateCreated'] = date_created.strftime('%FT%T') if date_created
      @post['mt_allow_comments'] = @headers['Comments'] =~ /\b(on|1|y(es)?)\b/i ? '1' : '0' if @headers['Comments']
      @post['mt_allow_pings'] = @headers['Pings'] =~ /\b(on|1|y(es)?)\b/i ? '1' : '0' if @headers['Pings']
      @post['mt_tags'] = @headers['Tags'] if @headers['Tags']
      @post['mt_basename'] = @headers['Basename'] if @headers['Basename']
    elsif self.mode == 'wp'
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
    self.endpoint
    fetch_credentials_from_keychain() unless @password
    @password
  end

  def post
    parse_post() if @post == nil
    @post
  end

  def post=(new_post)
    @post = new_post
    @post_id = self.post['postid'] if self.post['postid']
  end

  def post_id
    parse_post() if @post == nil
    @post_id
  end

  def publish
    parse_post() if @post == nil
    @publish
  end

  def headers
    parse_post() if @post == nil
    @headers
  end

  def endpoint=(new_endpoint)
    @endpoint = new_endpoint
    parse_endpoint()
  end

  def endpoint
    return @endpoint if @endpoint != nil

    current_endpoint = nil

    # Check the headers for a 'Blog' which is an endpoint
    current_endpoint = self.headers['Blog']

    # Check TM_BLOG_ENDPOINT as a fallback
    current_endpoint ||= ENV['TM_BLOG_ENDPOINT']

    # Still no luck? Ask the user using endpoints in their config.
    current_endpoint ||= select_endpoint()

    TextMate.exit_discard if current_endpoint.nil?

    self.endpoint = current_endpoint
  end

  def endpoints
    read_endpoints() unless @endpoints
    @endpoints
  end

  def client
    @client ||= MetaWeblogClient.new(@host, @path)
    @client
  end

  # Utility methods

  def post_to_document
    doc = ''
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

    format = 'Markdown'
    format = 'HTML' if "#{self.post['description']}#{self.post['mt_text_more']}" =~
      /<(p|a|img|h[1-6]|strong|em|tt|code|pre)\b.*?>/i

    if post['mt_convert_breaks']
      if formats[self.post['mt_convert_breaks']]
        format = formats[self.post['mt_convert_breaks']]
      end
    elsif ENV['TM_BLOG_FORMAT']
      format = ENV['TM_BLOG_FORMAT']
    else
      # derive format from existing scope
      case ENV['TM_SCOPE']
      when /\.markdown/
        format = "Markdown"
      when /\.textile/
        format = "Textile"
      when /text\.blog\.html/
        format = "HTML"
      when /text\.blog\.plain/
        format = "Text"
      end
    end

    blog = self.endpoints[self.endpoint] || self.endpoint
    doc += "Type: Blog Post (#{format})\n"
    doc += "Blog: #{blog}\n"
    doc += "Link: #{self.post['permaLink']}\n" if self.post['permaLink']
    doc += "Post: #{self.post_id}\n"
    doc += "Title: #{self.post['title']}\n"
    doc += "Keywords: #{self.post['keywords']}\n" if self.post['keywords']
    doc += "Tags: #{self.post['mt_tags']}\n" if self.post['mt_tags'] && (self.post['mt_tags'] != '')
    if (self.mode == 'wp') && self.post['category']
      cats = self.post['category'].split(/,/)
      cats.each { | cat | doc += "Category: #{cat}\n" }
    end
    doc += "Format: #{self.post['mt_convert_breaks']}\n" if self.post['mt_convert_breaks']
    doc += sprintf "Date: %04d-%02d-%02d %02d:%02d:%02d\n",
      self.post['dateCreated'].year,
      self.post['dateCreated'].month,
      self.post['dateCreated'].day,
      self.post['dateCreated'].hour,
      self.post['dateCreated'].min,
      self.post['dateCreated'].sec
    if self.post['mt_allow_pings'] && (self.post['mt_allow_pings'] == 1)
      doc += "Pings: On\n"
    else
      doc += "Pings: Off\n"
    end
    if self.post['mt_allow_comments'] && (self.post['mt_allow_comments'] == 1)
      doc += "Comments: On\n"
    else
      doc += "Comments: Off\n"
    end
    doc += "Basename: " + self.post['mt_basename'] + "\n" if self.post['mt_basename']
    if self.post['categories']
      self.post['categories'].each do | cat |
        doc += "Category: #{cat}\n"
      end
    end
    doc += "\n"
    doc += self.post['description'].strip + "\n"
    unless self.post['mt_text_more'].nil?
      if (more = self.post['mt_text_more'].strip) && more != ''
        doc += "\n#{DIVIDER * 10}\n\n"
        if (self.mode == 'wp')
          more.gsub!('<!--more-->', DIVIDER * 10)
        end
        doc += more + "\n"
      end
    end
    doc
  end

  def request_title(default)
    s = TextMate.inputbox(%Q{--title 'Title of Post' \
      --informative-text 'Enter a title for this post.' \
      --text "#{default.gsub(/"/,'\"')}" \
      --button1 'Post' --button2 'Cancel'})
    case (a = s.split(/\n/))[0].to_i
      when 1: "#{a[1]}"
      when 2: TextMate.exit_discard
    end
  end

  def show_post_page
    begin
      current_password = self.password
      self.post = client.getPost(self.post_id, self.username, current_password)
      if self.publish && link = self.post['permaLink']
        require "#{ENV['TM_SUPPORT_PATH']}/lib/browser"
        Browser.load_url(link)
      end
      @mw_success = true
    rescue XMLRPC::FaultException => e
      # ignore for now?
    end
  end

  def select_post(posts)
    titles = []
    posts.each { |p| titles.push( '"' + p['title'].gsub(/"/, '\"') + '"' ) }

    result = TextMate.dropdown(%Q{--title 'Fetch Post' \
      --text 'Select a recent post to edit' \
      --button1 Load --button2 Cancel \
      --items #{titles.join(' ')}})

    result = result.split(/\n/)
    if result[0] == "1"
      return posts[result[1].to_i]
    end
    nil
  end

  def select_endpoint
    if self.endpoints.length == 2
      # there's only one endpoint here (we store two keys for each)
      # return the first one
      self.endpoints.each_key do | name |
        return name if name !~ /^https?:/
        return self.endpoints[name]
      end
    end

    titles = []
    self.endpoints.each_key do | name |
      next if name =~ /^https?:/
      titles.push( '"' + name.gsub(/"/, '\"') + '"' )
    end

    if titles.length == 0
      TextMate.exit_show_tool_tip("No blog accounts are configured.\nPlease see Help or run Setup Blogs command.")
    end

    titles.sort!
    result = TextMate.dropdown(%Q{--title 'Select Blog' \
      --text 'Choose a blog' \
      --button1 Ok --button2 Cancel \
      --items #{titles.join(' ')}})

    result = result.split(/\n/)
    if result[0] == "1"
      name = titles[result[1].to_i].gsub(/^"|"$/, '')
      return self.endpoints[name]
    end
    nil
  end

  # Command: Post

  def post_or_update
    if !post['title']
      filename = ENV['TM_FILENAME'] || ''
      filename.sub!(/\.[a-z]+$/, '') if filename
      self.post['title'] = request_title(filename)
    end

    begin
      current_password = self.password
      require "#{ENV['TM_SUPPORT_PATH']}/lib/progress.rb"
      TextMate.call_with_progress(:title => "Posting to Blog", :message => "Contacting Server “#{@host}”…") do
        if post_id
          result = client.editPost(self.post_id, self.username, current_password, self.post, self.publish)
        else
          self.post_id = client.newPost(self.blog_id, self.username, current_password, self.post, self.publish)
        end
        show_post_page()
      end
      @mw_success = true
      TextMate.exit_replace_document(post_to_document())
    rescue XMLRPC::FaultException => e
      TextMate.exit_show_tool_tip("Error: #{e.faultString} (#{e.faultCode})")
    end
  end

  # Command: Fetch

  def fetch
    begin
      # Makes sure endpoint is determined and elements are parsed
      current_password = self.password
      require "#{ENV['TM_SUPPORT_PATH']}/lib/progress.rb"
      result = nil
      TextMate.call_with_progress(:title => "Fetch Post", :message => "Contacting Server “#{@host}”…") do
        result = self.client.getRecentPosts(self.blog_id, self.username, current_password, 20)
      end
      if !result || !result.length
        TextMate.exit_show_tool_tip("No posts are available!")
      end
      @mw_success = true
      if self.post = select_post(result)
        TextMate.exit_create_new_document(post_to_document())
      else
        TextMate.exit_discard
      end
    rescue XMLRPC::FaultException => e
      TextMate.exit_show_tool_tip("Error retrieving posts. Check your configuration and try again.")
    end
  end

  # Command: View

  def view
    if self.post_id
      show_post_page()
    else
      TextMate.exit_show_tool_tip("A Post ID is required to view the post.")
    end
  end

  # 'blog' Command (snippet)

  def choose_blog_endpoint
    if self.endpoints.length == 2
      current_endpoint = nil
      self.endpoints.each_key do | name |
        if name !~ /^https?:/
          current_endpoint = name
        else
          current_endpoint = self.endpoints[name]
        end
        break
      end
      TextMate.exit_insert_snippet("Blog: #{current_endpoint}")
    end

    titles = []
    self.endpoints.each_key do | name |
      next if name =~ /^https?:/
      titles.push( '"' + name.gsub(/"/, '\"') + '"' )
    end
    titles.sort!

    result = TextMate.dropdown(%Q{--title 'Select Blog' \
      --text 'Choose a Blog' \
      --button1 Ok --button2 Cancel \
      --items #{titles.join(' ')}})

    result = result.split(/\n/)

    if result[0] == "1"
      TextMate.exit_insert_snippet("Blog: " +
        titles[result[1].to_i].gsub(/^"|"$/, '') + '$0')
    end
    TextMate.exit_show_tool_tip(%Q{No blogs have been configured.\n} +
      %q{Use the "Setup Blogs" command."})
  end

  def to_html
    # endpoint doesn't matter here so set to something bogus
    # to prevent TM from asking for one...
    @endpoint = 'x'
    format = ENV['TM_SCOPE']
    doc = "#{self.post['description']}"
    doc += "#{self.post['mt_text_more']}" if self.post['mt_text_more']
    base = %Q{<base href="#{self.headers['Link']}" />} if self.headers['Link']
    html = <<-HTML
<html>
<head>
  <title>#{self.post['title']}</title>
  #{base}
  <style type="text/css">
    body {  
      background-color: #eee;
    }
    body > h1 {
      font-size: large;
    }
    .contents { 
      background: white;
      font-family: Georgia, serif;
      font-size: 13px;
      border: 1px #888 solid;
      padding: 0 1em;
    }
  </style>
</head>
<body>
<h1>#{post['title']}</h1>
<div class="contents">
HTML
    case format
      when /\.textile/
        require "#{ENV['TM_SUPPORT_PATH']}/lib/redcloth.rb"
        html += RedCloth.new(doc).to_html
      when /\.markdown/
        require "#{ENV['TM_SUPPORT_PATH']}/lib/bluecloth.rb"
        require "#{ENV['TM_SUPPORT_PATH']}/lib/rubypants.rb"
        html += RubyPants.new(BlueCloth.new(doc).to_html).to_html
      when /\.html/
        html += doc
      when /\.text/
        html += %Q{<div style="white-space: pre">#{doc}</div>}
    end
    html += "</div></body></html>"
    html
  end

  # Command: Preview

  def preview
    print to_html()
  end

  # Drag Command: Upload Image

  def upload_image
    # Makes sure endpoint is determined and elements are parsed
    current_password = password

    require "#{ENV['TM_SUPPORT_PATH']}/lib/progress.rb"
    file_path = ENV['TM_DROPPED_FILEPATH']
    data = {}
    file = File.basename(file_path)
    height_width = ""
    if sips_hw = %x{sips -g pixelWidth -g pixelHeight "#{file_path}"}
      height = $1 if sips_hw.match(/pixelHeight:[ ]*(\d+)/)
      width = $1 if sips_hw.match(/pixelWidth:[ ]*(\d+)/)
      if height && width
        height_width = %Q{ height="#{height}" width="#{width}"}
      end
    end
    name = file
    unless mode == 'wp'
      # WordPress automatically places files into dated paths
      date = Time.now.strftime("%Y-%m-%d")
      name = "#{date}_#{file}"
    end
    # Replace spaces with a dash
    name.gsub!(/[ ]+/, '-')

    if ENV['TM_MODIFIER_FLAGS'] =~ /OPTION/
      result = TextMate.inputbox(%Q{--title 'Rename Uploaded File' \
        --informative-text 'Enter the filename for this image' \
        --text "#{name.gsub(/"/,'\"')}" \
        --button1 'Upload' --button2 'Cancel'})
      case (a = result.split(/\n/))[0].to_i
        when 1: name = "#{a[1]}"
        when 2: TextMate.exit_discard
      end
    end

    data['name'] = name
    require 'xmlrpc/base64'
    data['bits'] = XMLRPC::Base64.new(IO.read(file_path))

    TextMate.call_with_progress(:title => "Upload Image", :message => "Uploading to Server “#{@host}”…") do
      begin
        result = client.newMediaObject(self.blog_id, self.username, current_password, data)
        url = result['url']
        if url
          alt = file.split('.').first.gsub(/[_-]/, ' ').gsub(/\w+/) { |m| m.capitalize }
          case ENV['TM_SCOPE']
            when /\.markdown/
              print "![${1:#{alt}}](#{url})"
            when /\.textile/
              print "!#{url} (${1:#{alt}})!"
            else
              print %Q{<img src="#{url}" alt="${1:#{alt}}"#{height_width} />}
          end
        else
          TextMate.exit_show_tool_tip("Error uploading image.")
        end
      rescue XMLRPC::FaultException => e
        TextMate.exit_show_tool_tip("Error uploading image. Check your configuration and try again.")
      end
    end
  end

end