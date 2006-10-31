require "socket"

class Client
  def initialize
    port = File.open(File.expand_path("~/Library/Application Support/TerminalMate/server.bin")) { |file|
      Marshal.load(file)
    }
    p port
    @socket = TCPSocket.new("127.0.0.1", port)
  end

  def send(*args)
    @socket.puts(*args)
  end
end

Client.new.send("foo", "akdlsfjalsdkjf")