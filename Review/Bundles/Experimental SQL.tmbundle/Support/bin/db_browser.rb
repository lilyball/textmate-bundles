#!/usr/bin/env ruby

# Add the path to the bundled libs to be used if the native bindings aren't installed
$: << ENV['TM_BUNDLE_SUPPORT'] + '/lib/connectors' if ENV['TM_BUNDLE_SUPPORT']

require 'optparse'
require 'ostruct'
require File.dirname(__FILE__) + '/db_browser_lib'

NO_TABLE = '__none__'

@options = OpenStruct.new
@options.server    = 'mysql'
@options.offset    = 0
@options.page_size = 10
@options.mode      = 'home'

@options.database = OpenStruct.new
@options.database.host     = nil
@options.database.user     = nil
@options.database.password = nil
@options.database.port     = nil
@options.database.name     = nil
@options.database.table    = nil

# Parse commandline options
begin
  OptionParser.new do |opts|
    opts.banner = "Usage: db_browse.rb [options]"

    opts.on("--server database", ['mysql', 'postgresql'], "Set database driver (mysql, postgresql, default mysql)") { |database| @options.server = database }
    opts.on("--database database", "Set database name") { |database| @options.database.name = database }
    opts.on("--host host", "Set database host") { |host| @options.database.host = host }
    opts.on("--table table", "Set database table") { |table| @options.database.table = table }
    opts.on("--user user", "Set database user") { |user| @options.database.user = user }
    opts.on("--password password", "Set database password") { |password| @options.database.password = password }
    opts.on("--port port", OptionParser::DecimalInteger, "Set database port") { |port| @options.database.port = port }
    opts.on("--query query", "Run query on database") { |query| @options.query = query }
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

# Load connectors and set missing defaults
if @options.server == 'mysql'
  @options.database.name     ||= ENV['MYSQL_DB'] || ENV['USER']
  @options.database.host     ||= (ENV['MYSQL_HOST'] || 'localhost')
  @options.database.user     ||= (ENV['MYSQL_USER'] || ENV['USER'])
  @options.database.password ||= ENV['MYSQL_PWD']
  @options.database.port     ||= (ENV['MYSQL_PORT'] || 3306).to_i
elsif @options.server == 'postgresql'
  @options.database.name     ||= (ENV['PGDATABASE'] || ENV['USER'])
  @options.database.host     ||= (ENV['PGHOST'] || 'localhost')
  @options.database.user     ||= (ENV['PGUSER'] || ENV['USER'])
  @options.database.password ||= ENV['PGPASS']
  @options.database.port     ||= (ENV['PGPORT'] || 5432).to_i
else
  puts "Unsupported server type: #{@options.server}"
  exit
end

@options.database.table ||= ENV['TM_DB_TABLE'] # Allow a default table to be specified
if @options.database.table and @options.database.table.include? '.'
  @options.database.schema, @options.database.table = @options.database.table.split('.')
end

begin
  @connection = Connector.new(@options.server, @options.database)
rescue LoadError
  puts "Database connection library not found [#{$!}]"
  exit
end

if @options.mode == 'version'
  puts @connection.server_version
  exit
end

def get_data_link(link, new_params = {})
  params = []
  params << (new_params[:database] || @options.database.name)
  params << (new_params[:table] || @options.database.table)
  params << new_params[:query].to_s
  params << @options.page_size
  params << new_params[:offset].to_s
  params.map!{|param| '%22' + param.to_s + '%22' }
  "<a href='javascript:getData(" + params.join(', ') + ")'>" + link + "</a>"
end

def e_js(str)
  str.to_s.gsub(/(?=['\\])/, '\\')
end

def print_script_tag
  puts <<-HTML
  <script src="file://#{ENV['TM_BUNDLE_SUPPORT']}/lib/shell.js"></script>
  <script>
  var server = '#{e_js @options.server}';
  var host = '#{e_js @options.database.host}';
  var port = '#{e_js @options.database.port}';
  var user = '#{e_js @options.database.user}';
  var pass = '#{e_js @options.database.password}';

  function getData(db, tbl, query, page_size, offset) {
    var res = shell_run("#{__FILE__}", '--mode=frame', shell_join_long_args({database: db, table: tbl, host: host, server: server, password: pass, user: user, port: port, query: query, rows: page_size, offset: offset}));
    document.getElementById("result").innerHTML = res;
  }
  function toggleDatabases(database, tbl, hname, stype, pw, dbuser, dbport, query, page_size, offset) {
    database_name = database.innerText;
    list = document.getElementById('db_' + database_name);
    if (list.childNodes.length == 0) {
      var res = shell_run("#{__FILE__}", '--mode=tables', shell_join_long_args({database: database_name, host: host, server: server, password: pass, user: user, port: port}));
      TextMate.log(res);
      list.innerHTML = res;
      list.style.display = 'block';
    } else if (list.style.display != 'block') {
      list.style.display = 'block';
    } else {
      list.style.display = 'none';
    }
    TextMate.log('done');
  }
  </script>
  HTML
end

def list_databases
  databases = @connection.database_list
  # Output
  Tag.h2 'Databases', :align => 'center'
  Tag.ul(:id => 'database_list') do
    databases.each do |database|
      Tag.li do 
        Tag.a database, :onclick => "javascript: toggleDatabases(this);", :href => '#'
        Tag.ul(:id => "db_#{database}", :class => "table_list", :style => ('display: block' if @options.database.name == database) ) do
          # @connection.table_list(database).each do |table|
          #   Tag.li get_data_link(table, :database => database, :table => table)
          # end
        end
      end
    end
  end
end

def list_columns
  Tag.h2 'Columns in table: ' + @options.database.table
  Tag.table(:width => '75%', :class => 'graybox', :cellspacing => '0', :cellpadding => '5') do
    Tag.tr do
      Tag.th 'Name', :align => 'left'
      Tag.th 'Type', :align => 'left'
      Tag.th 'Nullable', :align => 'left'
      Tag.th 'Default', :align => 'left'
    end
    @connection.get_fields.each do |field|
      Tag.tr do
        Tag.td field[:name]
        Tag.td field[:type]
        Tag.td field[:nullable]
        Tag.td field[:default].nil? ? 'NULL' : field[:default]
      end
    end
  end
end

def print_data(query = nil)
  page_size = @options.page_size
  offset = @options.offset

  if not query or query.to_s.size == 0
    query = "SELECT * FROM %s" % @options.database.table
    page_size = 5
    offset = 0
  end
  run_query = query.dup
  if not query.include?('LIMIT') and run_query =~ /\s*SELECT/i
    limited = true
    run_query << ' LIMIT %d OFFSET %d' % [page_size, offset]
  end
  begin
    res = @connection.do_query(run_query)
    if res.is_a? Result
      if res.num_rows == 0
        Tag.h2 'There are no records to show'
        Tag.p run_query, :class => 'query'
      else
        Tag.h2 'Records %d to %d' % [offset, offset + res.num_rows]
        Tag.p run_query, :class => 'query'
        if not limited
          puts get_data_link('&lt;&nbsp;Prev', :query => query, :offset => [@options.offset - page_size, 0].max) if @options.offset > 0
          puts get_data_link('Next&nbsp;&gt;', :query => query, :offset => @options.offset + page_size)
        end
        Tag.table(:class => 'graybox', :cellspacing => '0', :cellpadding => '5') do
          Tag.tr do
            res.fields.each do |field|
              Tag.th field
            end
          end
          res.rows.each do |row|
            Tag.tr do
              row.each do |col|
                Tag.td col.to_s[0..30].gsub('<', '&lt;')
              end
            end
          end
        end
        Tag.br
      end
    else
      Tag.h2 'Query complete, ' + res.to_s + ' rows affected'
      Tag.p run_query, :class => 'query'
    end
  rescue
    Tag.h2 "Invalid query: "
    Tag.p run_query, :class => 'query'
  end
end

if @options.mode == 'tables'
  @connection.table_list(@options.database.name).each do |table|
    Tag.li get_data_link(table, :database => @options.database.name, :table => table)
  end
elsif @options.mode == 'home'
  print_script_tag
  Tag.div :id => 'main' do
    Tag.div :id => 'result' do
      if @options.query.to_s.size > 0
        print_data @options.query
      else
        puts File.read(ENV['TM_BUNDLE_SUPPORT'] + '/install.html') if ENV['TM_BUNDLE_SUPPORT']
      end
    end
  end
  Tag.div :id => 'dbbar' do
    list_databases
  end
elsif @options.query.to_s.size > 0
  print_data @options.query
elsif @options.database.table
  if @options.database.table != NO_TABLE
    list_columns
    print_data
  end
end