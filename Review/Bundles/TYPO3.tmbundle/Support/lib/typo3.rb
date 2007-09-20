require 'cgi'
require "#{ENV['TM_SUPPORT_PATH']}/../Bundles/Blogging.tmbundle/Support/lib/textmate.rb"
require "#{ENV['TM_SUPPORT_PATH']}/../Bundles/Blogging.tmbundle/Support/lib/keychain.rb"
require "#{ENV['TM_BUNDLE_SUPPORT']}/lib/typo3client.rb"

$KCODE = 'u'

class Typo3
  DIVIDER = '✂------'
  BLOG_ACCOUNTS_FILE = File.expand_path("~/Library/Preferences/com.macromates.textmate.typo3.txt")

  # These elements are gathered from the environment; no need to explicitly
  # write to them.
  attr_reader :site_id, :username, :host, :path, :mode, :headers, :publish

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
    endpoint_path = self.path.dup
    endpoint_path.sub!(/#.+/, '') if endpoint_path =~ /#.+/
    KeyChain.add_internet_password(self.username, protocol, self.host,
      endpoint_path, self.password)
  end

  def finally_save_new_endpoint
    if File.exist?(BLOG_ACCOUNTS_FILE)
      endpoint_list = IO.readlines(BLOG_ACCOUNTS_FILE)
    else
      endpoint_list = [ <<-TEXT ]
# Blogging Account List
# Enter a blog name followed by the endpoint URL (see Help for proxy config)
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
    endpoint_path = self.path.dup
    endpoint_path.sub!(/#.+/, '') if endpoint_path =~ /#.+/
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
        current_endpoint = self.endpoint.dup
        current_endpoint.sub!(/#.+/, '') if current_endpoint =~ /#.+/
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
        @username = CGI.unescape($1)
        @password = CGI.unescape($2) if $2
        @host = $3
      end
    else
      TextMate.exit_show_tool_tip("Error: invalid endpoint specified: #{@endpoint}")
    end

    if @endpoint =~ /#(.+)/
      @site_id = $1
    else
      @site_id = "0"
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
          key = $1.downcase
          case key
          when 'ping'
            @post['mt_tbping_urls'] = [] unless @post['mt_tbping_urls']
            @post['mt_tbping_urls'].push($2)
          when 'category'
            @post['categories'] = [] unless @post['categories']
            @post['categories'].push($2)
          when 'status'
            @publish = false if $2 =~ /draft/i
          end
          @headers[key] = $2
          next
        else
          in_headers = false
        end
      end
      if line =~ %r{^✂-[✂-]+}
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
      @post['mt_text_more'] = "\n" + @post['mt_text_more']
    end
    @post['title'] = @headers['title'] if @headers['title']
    self.post_id = @headers['post'].to_i if @headers['post']

    format = @headers['format']
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

    date_created = DateTime.parse(@headers['date']) if @headers['date']
    if date_created && self.mode != 'mt' && (self.mode != 'wp' || ENV['TM_SEND_DATE_TO_WP']) then
      # Convert to GMT and then to an XMLRPC:DateTime object to
      # workaround xmlrpc/create.rb’s poor handling of DateTime.
      d = date_created.new_offset(0)
      @post['dateCreated'] = XMLRPC::DateTime.new(d.year, d.mon, d.day, d.hour, d.min, d.sec)
    end

    if self.mode == 'mt'
      @post['dateCreated'] = date_created.strftime('%FT%T') if date_created
      @post['mt_allow_comments'] = @headers['comments'] =~ /\b(on|1|y(es)?)\b/i ? '1' : '0' if @headers['comments']
      @post['mt_allow_pings'] = @headers['pings'] =~ /\b(on|1|y(es)?)\b/i ? '1' : '0' if @headers['pings']
      @post['mt_tags'] = @headers['tags'] if @headers['tags']
      @post['mt_basename'] = @headers['basename'] if @headers['basename']
    elsif self.mode == 'wp'
      @post['mt_allow_comments'] = @headers['comments'] =~ /\b(on|1|y(es)?)\b/i ? 'open' : 'closed' if @headers['comments']
      @post['mt_allow_pings'] = @headers['pings'] =~ /\b(on|1|y(es)?)\b/i ? 'open' : 'closed' if @headers['pings']
    end
    @post['mt_keywords'] = @headers['keywords'] if @headers['keywords']
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
    current_endpoint = self.headers['typo3']

    # Check TM_BLOG_ENDPOINT as a fallback
    current_endpoint ||= ENV['TM_TYPO3_ENDPOINT']

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
    current_endpoint = endpoint.dup
    current_endpoint.sub!(/#.+/, '') if current_endpoint =~ /#.+/
    @client ||= Typo3Client.new2(current_endpoint, ENV['TM_HTTP_PROXY'])
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
    doc += "Keywords: #{self.post['mt_keywords']}\n" if self.post['mt_keywords']
    doc += "Tags: #{self.post['mt_tags']}\n" if self.post['mt_tags'] && (self.post['mt_tags'] != '')
    if (self.mode == 'wp') && self.post['category']
      cats = self.post['category'].split(/,/)
      cats.each { | cat | doc += "Category: #{cat}\n" }
    end
    doc += "Format: #{self.post['mt_convert_breaks']}\n" if self.post['mt_convert_breaks']

    # Convert XMLRPC:DateTime to a regular DateTime object so
    # that we can show the date using the users local time zone.
    d = DateTime.civil(*self.post['dateCreated'].to_a)
    doc += d.new_offset(DateTime.now.offset).strftime("Date: %F %T %z") + "\n"

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
    result = TextMate.input_box('Title of Post', 'Enter a title for this post.', default, 'Post')
    TextMate.exit_discard if result.nil?
    result
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
      TextMate.exit_show_tool_tip("No Typo3 accounts are configured.\nPlease see Help or run Setup Typo3 Sites command.")
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
          self.post_id = client.newPost(self.site_id, self.username, current_password, self.post, self.publish)
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
        result = self.client.get_list(self.site_id, self.username, current_password)
      end
      if !result || !result.length
        TextMate.exit_show_tool_tip("No templates are available!")
      end
      @mw_success = true
      if self.post = select_post(result)
        TextMate.exit_create_new_document(post_to_document())
      else
        TextMate.exit_discard
      end
    rescue XMLRPC::FaultException => e
      TextMate.exit_show_tool_tip("Error: #{e.faultString} (#{e.faultCode})")
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
    if self.endpoints.length == 0
      TextMate.exit_show_tool_tip(%Q{No blogs have been configured.\n} +
        %q{Use the "Setup Blogs" command."})
    end

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

    # TBD: preserve order from endpoint file
    titles = []
    self.endpoints.each_key do | name |
      next if name =~ /^https?:/
      titles.push(name)
    end
    titles.sort!

    require "#{ENV['TM_SUPPORT_PATH']}/lib/ui.rb"
    opt = TextMate::UI.menu(titles)

    if opt != nil
      TextMate.exit_insert_snippet("Blog: " + titles[opt] + '$0')
    end
  end

  def to_html
    # endpoint doesn't matter here so set to something bogus
    # to prevent TM from asking for one...
    @endpoint = 'x'
    format = ENV['TM_SCOPE']
    doc = "#{self.post['description']}"
    doc += "#{self.post['mt_text_more']}" if self.post['mt_text_more']
    if self.headers['link']
      base = %Q{<base href="#{self.headers['link']}" />}
    elsif ENV['TM_FILEPATH']
      filepath = ENV['TM_FILEPATH'].dup
      filepath.gsub!(/ /, '%20')
      base = %Q{<base href="file://#{filepath}" />}
    end
    html = `. "${TM_SUPPORT_PATH}/lib/webpreview.sh"; html_header Preview Blogging`
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
    html += `. "${TM_SUPPORT_PATH}/lib/webpreview.sh"; html_footer`
    html
  end

  # Command: Preview

  def preview
    print to_html()
  end

  # Drag Command: Upload Image

  def upload_name_for_path(full_path)
    require "#{ENV['TM_SUPPORT_PATH']}/lib/escape.rb"

    # WordPress automatically places files into dated paths
    prefix = mode == 'wp' ? '' : Time.now.strftime('%F_')
    file   = File.basename(full_path)

    if ENV['TM_MODIFIER_FLAGS'] =~ /OPTION/

      suggested_name = prefix + file.gsub(/[ ]+/, '-')
      result = TextMate.input_box('Upload Image', 'Name to use for uploaded file:', suggested_name, 'Upload')
      TextMate.exit_discard if result.nil?

      alt = result.sub(/\.[^.]+\z/, '').gsub(/[_-]/, ' ').capitalize.gsub(/\w{4,}/) { |m| m.capitalize }
      [ result, alt ]

    else

      base          = file.sub(/\.[^.]+\z/, '')
      ext           = file[(base.length)..-1]
      suggested_alt = base.gsub(/[_-]/, ' ').gsub(/[a-z](?=[A-Z0-9])/, '\0 ').capitalize.gsub(/\w{4,}/) { |m| m.capitalize }

      result = TextMate.input_box('Upload Image', 'Image description (a filename will be derived from it):', suggested_alt, 'Upload')
      TextMate.exit_discard if result.nil?

      require "iconv"
      name = Iconv.new('ASCII//TRANSLIT', 'UTF-8').iconv(result.dup)

      name.gsub!(/[^-_ \/\w]/, '') # remove strange stuff
      name.gsub!(/[-_ \/]+/, '_')  # collapse word separators into one underscore
      name.downcase!
      [ prefix + name + ext, result ]

    end
  end

  def upload_image
    require "#{ENV['TM_SUPPORT_PATH']}/lib/progress.rb"
    require "#{ENV['TM_SUPPORT_PATH']}/lib/escape.rb"
    require 'xmlrpc/base64'

    # Makes sure endpoint is determined and elements are parsed
    current_password = password

    # The packet we will be constructing
    data = {}

    full_path = ENV['TM_DROPPED_FILEPATH']
    upload_name, alt = upload_name_for_path(full_path)

    data['name'] = upload_name
    data['bits'] = XMLRPC::Base64.new(IO.read(full_path))

    TextMate.call_with_progress(:title => "Upload Image", :message => "Uploading to Server “#{@host}”…") do
      begin
        result = client.newMediaObject(self.site_id, self.username, current_password, data)
        url = result['url']
        if url
          case ENV['TM_SCOPE']
            when /\.markdown/
              print "![${1:#{alt}}](#{url})"
            when /\.textile/
              print "!#{url} (${1:#{alt}})!"
            else
              height_width = ""
              if sips_hw = %x{sips -g pixelWidth -g pixelHeight #{e_sh full_path}}
                height = $1 if sips_hw.match(/pixelHeight:[ ]*(\d+)/)
                width  = $1 if sips_hw.match(/pixelWidth:[ ]*(\d+)/)
                if height && width
                  height_width = %Q{ height="#{height}" width="#{width}"}
                end
              end
              print %Q{<img src="#{url}" alt="${1:#{CGI::escapeHTML alt}}"#{height_width}#{ENV['TM_XHTML']}>}
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