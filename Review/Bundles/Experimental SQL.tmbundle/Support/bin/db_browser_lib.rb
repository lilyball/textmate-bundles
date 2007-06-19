# Add the path to the bundled libs to be used if the native bindings aren't installed
$: << ENV['TM_BUNDLE_SUPPORT'] + '/lib/connectors' if ENV['TM_BUNDLE_SUPPORT']

class Connector
  @@connector = nil

  def initialize(server, settings)
    @server = server
    @settings = settings
    if @server == 'mysql'
      require 'mysql'
    elsif @server == 'postgresql'
      require 'postgres-compat'
    end
  end

  def do_query(query, database = nil)
    if @server == 'postgresql'
      mycon = self.get_pgsql(database)
      res = mycon.query(query)
    elsif @server == 'mysql'
      mycon = self.get_mysql(database)
      res = mycon.query(query)
    end
    if res
      Result.new(res)
    else
      mycon.affected_rows
    end
  end
  
  def server_version
    if @server == 'mysql'
      res = self.get_mysql.query('SHOW VARIABLES LIKE "version"')
      res.fetch_row[1]
    else
      puts "Not implemented for PGSQL yet!"
      exit
    end
  end

  def get_mysql(database = nil)
    @@connector ||= Mysql::new(@settings.host, @settings.user, @settings.password, database || @settings.name, @settings.port)
    @@connector
  end

  def get_pgsql(database = nil)
    @@connector ||= PostgresPR::Connection.new(database || @settings.name, @settings.user, @settings.password, 'tcp://' + @settings.host + ":" + @settings.port.to_s)
    @@connector
  end
  
  ####
  def table_list(database = nil)
    if @server == 'postgresql'
      query = "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'"
    elsif @server == 'mysql'
      query = 'SHOW TABLES'
    end
    tables = []
    do_query(query, database).rows.each {|row| tables << row[0] }
    tables
  end

  def database_list
    databases = []
    if @server == 'postgresql'
      db_list = `psql -l --host="#{@settings.host}" --port="#{@settings.port}" --user="#{@settings.user}" --html 2>&1`.to_a
      raise Exception.new(db_list) unless $?.to_i == 0
      while line = db_list.shift
        databases << $2 if db_list.shift.match(/\s+(<td align=.*?>)(.*?)(<\/td>)/) if line.include? '<tr valign'
      end
    elsif @server == 'mysql'
      db_list = `mysql -e 'show databases' --host="#{@settings.host}" --port="#{@settings.port}" --user="#{@settings.user}" --password="#{@settings.password}" --xml 2>&1`
      raise Exception.new(db_list) unless $?.to_i == 0
      db_list.each_line { |line| databases << $1 if line.match(/<(?:Database|field name="Database")>(.+)<\/(Database|field)>/) }
    end
    databases
  end

  def get_fields(table = nil)
    table ||= @settings.table
    field_list = []
    if @server == 'postgresql'
      query = "SELECT column_name, data_type, is_nullable, ordinal_position, column_default FROM information_schema.columns
                WHERE table_name='%s' ORDER BY ordinal_position" % table
    elsif @server == 'mysql'
      query = 'DESCRIBE ' + table
    end
    fields = do_query(query).rows
    fields.each { |field| field_list << {:name => field[0], :type => field[1], :nullable => field[2], :default => field[4]} }
    field_list
  end
end

class Result
  def initialize(res)
    @res = res
  end

  def rows
    if @res.is_a? Mysql::Result
      @res
    elsif @res == PostgresPR::Connection::Result
      @res.rows
    end
  end
  
  def fields
    if @res.is_a? Mysql::Result
      @res.fetch_fields.map do |field|
        {:name => field.name,
         :type => [Mysql::Field::TYPE_DECIMAL, Mysql::Field::TYPE_TINY, Mysql::Field::TYPE_SHORT,
                   Mysql::Field::TYPE_LONG, Mysql::Field::TYPE_FLOAT, Mysql::Field::TYPE_DOUBLE].include?(field.type) ? :number : :string }
      end
    elsif @res == PostgresPR::Connection::Result
      @res.fields.map{|field| {:name => field.name, :type => :string } }
    end
  end
  
  def num_rows
    @res.num_rows
  end
end

def get_connection
  # Load connectors and set missing defaults
  if @options.server == 'mysql'
    @options.database.name     ||= ENV['MYSQL_DB']    || ENV['USER']
    @options.database.host     ||= (ENV['MYSQL_HOST'] || 'localhost')
    @options.database.user     ||= (ENV['MYSQL_USER'] || ENV['USER'])
    @options.database.password ||= ENV['MYSQL_PWD']
    @options.database.port     ||= (ENV['MYSQL_PORT'] || 3306).to_i
  elsif @options.server == 'postgresql'
    @options.database.name     ||= (ENV['PGDATABASE'] || ENV['USER'])
    @options.database.host     ||= (ENV['PGHOST']     || 'localhost')
    @options.database.user     ||= (ENV['PGUSER']     || ENV['USER'])
    @options.database.password ||= ENV['PGPASS']
    @options.database.port     ||= (ENV['PGPORT']     || 5432).to_i
  else
    puts "Unsupported server type: #{@options.server}"
    exit
  end

  begin
    @connection = Connector.new(@options.server, @options.database)
  rescue LoadError
    TextMate::exit_show_tool_tip "Database connection library not found [#{$!}]"
  end
end