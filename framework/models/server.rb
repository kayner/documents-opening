# frozen_string_literal: true

# Class for creating Appium Server
class Server
  attr_reader :appium_port, :system_port, :udid

  @@appium_port = 8500
  @@system_port = 8700

  # @param [String] udid, Device udid
  # @return [AppiumServer] instance
  def initialize(udid)
    @udid = udid
    @appium_port = @@appium_port
    @system_port = @@system_port
    @@appium_port += 1
    @@system_port += 1
  end

  def run
    system "x-terminal-emulator -e appium -p #{@appium_port} -dc \"{\\\"udid\\\":"\
            " \\\"#{@udid}\\\", \\\"systemPort\\\":#{@system_port}}\""
  end
end
