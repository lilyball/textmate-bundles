require "socket"

module TerminalMate
  
  class Client
    def initialize
      port = File.open(File.expand_path("~/Library/Application Support/TerminalMate/server.bin")) { |file|
        Marshal.load(file)
      }
      @socket = TCPSocket.new("127.0.0.1", port)
    end
    
    def send(*args)
      args.map! { |a| a.to_s } # map nils to an empty string
      @socket.puts(*args)
    end
  end
  
end