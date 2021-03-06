require "socket"
require "json"

require_relative 'player'

class RemotePlayer < Player
  
  PORT = 2000
  
  def initialize(board, color, address = nil)
    super(board, color)
    
    if address.nil?
      puts "Waiting for client to connect"
      server = TCPServer.new(PORT)
      self.stream = server.accept
      
    else
      puts "Connecting to #{address}:#{PORT}"
      self.stream = TCPSocket.new(address, PORT)
    end
    
    puts "Connected!"
    sleep 2
    
  end
  
  def send_move(move)
    self.stream.puts "#{move.to_json}\n"
  end
  
  def get_move
    move = self.stream.gets.chomp
    JSON::parse(move)
  end
  
end
