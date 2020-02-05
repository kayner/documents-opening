# frozen_string_literal: true

# Class for device control
class Device
  attr_reader :driver, :udid, :config, :caps, :name

  # @param [Hash] config, Config for device
  # @return [Device] instance
  def initialize(config, caps)
    @config = config[:config]
    @name = config[:name]
    @udid = config[:udid]
    @caps = caps
    @caps[:deviceName] = config[:name]
    @caps[:udid] = config[:udid]
    @driver = nil
  end

  # @param [AppiumServer] to, AppiumServer instance
  # @return [Selenium::WebDriver] driver instance
  def connect(to:)
    @driver = Appium::Driver.new({ caps: @caps,
                                   appium_lib: { port: to.appium_port } },
                                 false)
    @driver.start_driver
  end

  def disconnect
    @driver.driver_quit
  end
end
