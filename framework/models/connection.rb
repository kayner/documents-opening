# frozen_string_literal: true

# Class for control connections between driver and server
class Connection
  attr_reader :device, :server

  def initialize(device)
    @device = device
    @server = Server.new(@device.udid)
  end

  def start
    @server.run
    sleep 2
    @device.connect to: @server
  end

  def stop
    @device.disconnect
  end
end
