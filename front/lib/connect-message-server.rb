require 'singleton'
require 'SocketIO'

class ConnectMessageServer
  include Singleton

  def connect
    @client = SocketIO.connect("http://localhost:8000") do
      before_start do
        on_message {|message| puts "incoming message: #{message}"}
        on_event('news') { |data| puts data.first} # data is an array fo things.
      end

      after_start do
        emit "auth", passward:"passward"
      end
    end
  end

  def auth
  end

end

