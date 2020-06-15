# frozen_string_literal: true

# Class for working with Appium Server
class Server
  attr_reader :appium_port, :port, :udid

  def initialize(udid, appium_port, system_port)
    @udid = udid
    @appium_port = appium_port
    @port = system_port
  end

  def run
    system "gnome-terminal -- appium -p #{@appium_port} -dc "\
            "\"{\\\"udid\\\":\\\"#{@udid}\\\",\\\"systemPort\\\":#{@port}}\""
    sleep 3
  end
end
