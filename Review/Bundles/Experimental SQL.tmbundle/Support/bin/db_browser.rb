#!/usr/bin/env ruby

require 'optparse'
require 'ostruct'
require 'erb'
require File.dirname(__FILE__) + '/db_browser_lib'
require 'cgi'
require "#{ENV["TM_SUPPORT_PATH"]}/lib/web_preview" if ENV["TM_SUPPORT_PATH"]

NO_TABLE = '__none__'

@options = OpenStruct.new
@options.offset    = 0
@options.page_size = 10
@options.mode      = 'home'

@options.database = OpenStruct.new
@options.database.server   = 'mysql'
@options.database.host     = nil
@options.database.user     = nil
@options.database.password = nil
@options.database.port     = nil
@options.database.name     = nil
@options.database.table    = nil

require "#{ENV["TM_SUPPORT_PATH"]}/lib/osx/plist" if ENV["TM_SUPPORT_PATH"]

# Parse commandline options
begin
  OptionParser.new do |opts|
    opts.banner = "Usage: db_browse.rb [options]"

    opts.on("--database database", "Set database name") { |database| @options.database.name = database }
    opts.on("--table table", "Set database table") { |table| @options.database.table = table }
    opts.on("--query query", "Run query on database") { |query| @options.query = query.to_s.strip }
    opts.on("--rows rows", OptionParser::DecimalInteger, "Set page size for query output") { |rows| @options.page_size = rows }
    opts.on("--offset offset", OptionParser::DecimalInteger, "Set offset") { |offset| @options.offset = offset }

    opts.on('--mode=mode', ['home', 'frame', 'tables']) { |mode| @options.mode = mode }
    
    opts.on('--version', 'Print mysql server version and exit') { @options.mode = 'version' }
    opts.on_tail("-h", "--help", "Show this message") { puts opts; exit }
  end.parse!
rescue OptionParser::InvalidOption, OptionParser::InvalidArgument, OptionParser::AmbiguousArgument => e
  puts e.reason + ": " + e.args.pop
  exit
end

begin
  get_connection_settings(@options.database)
  @connection = get_connection
rescue
  puts html_head(:window_title => "SQL", :page_title => "SQL Bundle", :sub_title => 'Configuration')
  print File.read(ENV['TM_BUNDLE_SUPPORT'] + '/install.html')
  html_footer
  exit
end

if @options.mode == 'version'
  puts @connection.server_version
  exit
end

def print_data(query = nil)
  @page_size = @options.page_size
  offset     = @options.offset
  if not query or query.to_s.size == 0
    query     = "SELECT * FROM %s" % @options.database.table
    @page_size = 5
    offset    = 0
  end
  run_query = query.sub(/;\s*$/, '')
  @limited  = true
  if not query=~ /\bLIMIT\b/i and run_query =~ /\s*SELECT/i
    run_query << ' LIMIT %d OFFSET %d' % [@page_size, offset]
    @limited = false
  end

  @query = query
  begin
    @result = @connection.do_query(run_query)
    if @result.is_a? Result
      @title = 'Query complete'
      if @result.num_rows == 0
        @message = 'There are no records to show'
      else
        @pager = 'Records %d to %d' % [offset + 1, offset + @result.num_rows]
      end
    else
      @message = @result.to_s + " row#{:s if @result.to_i != 1} affected"
    end
  rescue Exception => e
    @title = "Invalid query"

    if e.is_a? Mysql::Error
      @message = escape(smarty(e.message))
    else
      @message = "<b>#{e.class.name}: #{escape(smarty(e.message))}</b>"
      @message += '<pre>' + "\t" + escape(e.backtrace.join("\n\t")) + '</pre>'
    end
  end
  render('result')
end

# ====================
# = Template helpers =
# ====================
def smarty(text)
  text.to_s.
    sub(" -- ", ' — ').
    sub(/ -- /, ' — ')
end

def escape(text)
  CGI.escapeHTML(text.to_s)
end

def e_js(str)
  str.to_s.gsub(/(?=['\\])/, '\\')
end

def get_data_link(link, new_params = {})
  params = []
  params << (new_params[:database] || @options.database.name)
  params << (new_params[:table] || @options.database.table)
  params << new_params[:query].to_s
  params << @options.page_size
  params << new_params[:offset].to_s
  params.map!{|param| "'" + e_js(escape(param.to_s)) + "'" }
  '<a href="javascript:getData(' + params.join(', ') + ')">' + link + "</a>"
end

def render(template_file)
  template = File.read(File.dirname(__FILE__) + '/../templates/' + template_file + '.rhtml')
  ERB.new(template).result(binding)
end

# ===============
# = Entry point =
# ===============

if @options.mode == 'tables'
  @tables = @connection.table_list(@options.database.name)
  print render('tables')
elsif @options.mode == 'home'
  puts html_head(:window_title => "SQL", :page_title => "Database Browser", :sub_title => @options.database.name, :html_head => render('head'))
  STDOUT.flush
  @content = ''
  if @options.query.to_s.size > 0
    @content = print_data(@options.query)
  elsif ENV['TM_BUNDLE_SUPPORT']
    @content = '<h2>Database Browser</h2>Please choose a table from the left'
  end
  begin
    @databases = @connection.database_list
  rescue Exception => e
    abort e.message
  end
  print render('main')
  html_footer
elsif @options.query.to_s.size > 0
  print print_data(@options.query)
elsif @options.database.table
  if @options.database.table != NO_TABLE
    @table  = @options.database.table
    @fields = @connection.get_fields
    print render('columns')
    print print_data
  end
end
