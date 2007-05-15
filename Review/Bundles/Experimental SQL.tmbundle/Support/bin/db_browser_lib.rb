class Connector
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
    Mysql::new(@settings.host, @settings.user, @settings.password, database || @settings.name, @settings.port)
  end

  def get_pgsql(database = nil)
    PostgresPR::Connection.new(database || @settings.name, @settings.user, @settings.password, 'tcp://' + @settings.host + ":" + @settings.port.to_s)
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
      db_list = `psql -l --host="#{@settings.host}" --port="#{@settings.port}" --user="#{@settings.user}" --html`.to_a
      while line = db_list.shift
        databases << $2 if db_list.shift.match(/\s+(<td align=.*?>)(.*?)(<\/td>)/) if line.include? '<tr valign'
      end
    elsif @server == 'mysql'
      db_list = `mysql -e 'show databases' --host="#{@settings.host}" --port="#{@settings.port}" --user="#{@settings.user}" --password="#{@settings.password}" --xml`
      db_list.each_line { |line| databases << $1 if line.match(/<Database>(.+)<\/Database>/) }
    end
    databases
  end

  def get_fields
    field_list = []
    if @server == 'postgresql'
      query = "SELECT column_name, data_type, is_nullable, ordinal_position, column_default FROM information_schema.columns
                WHERE table_name='%s' ORDER BY ordinal_position" % @settings.table
    elsif @server == 'mysql'
      query = 'DESCRIBE ' + @settings.table
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
      fields = @res.fetch_fields
    elsif @res == PostgresPR::Connection::Result
      fields = @res.fields
    end
    fields.map{|field| field.name}
  end
  
  def num_rows
    @res.num_rows
  end
end

class Tag
  def self.method_missing(tag, *args)
    attributes = {}
    contents = ''
    args.each do |arg|
      attributes.merge!(arg) if arg.is_a? Hash
      contents << arg if arg.is_a? String
    end
    attrib_list = ''
    attributes.each_pair do |attrib, value|
      attrib_list << " #{attrib}=\"#{value}\""
    end
    print "<#{tag}#{attrib_list}>"
    if block_given?
      yield
    else
      print contents
    end
    puts "</#{tag}>"
  end
end