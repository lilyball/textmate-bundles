require "gserver"
require "fileutils"

class TerminalMateServer < GServer
  
  SUPPORT = File.expand_path('~/Library/Application Support/TerminalMate')
  
  def initialize
    FileUtils.mkdir_p(SUPPORT)
    log = File.open(SUPPORT + '/server.log', 'w')
    super(0, DEFAULT_HOST, 4, log, true, false)
  end

  def start
    super()
    log('Starting server…')
    File.open(SUPPORT + '/server.bin', 'w') do |f|
      Marshal.dump(port(), f)
    end
  end

  def serve(io)
    handle_request(io.gets.chomp, io.read)
  end
end

if __FILE__ == $PROGRAM_NAME
  a = TerminalMate.new
  def a.handle_request(id, data)
    log("handle_request: id=#{id.inspect} data=#{data.inspect}")
  end
  a.start
  a.join
end