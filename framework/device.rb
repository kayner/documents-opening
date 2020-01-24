# frozen_string_literal: true

# Class for device control
class Device
  attr_reader :driver, :config

  # @param [Hash] config, Config for device
  # @return [Device] instance
  def initialize(config)
    @config = config
    @capabilities = ConfigHelper.parse('config/config.json')[:capabilities]
    @capabilities[:deviceName] = config[:name]
    @capabilities[:udid] = config[:udid]
    @driver = nil
  end

  # @return [String] device name
  def name
    @config[:name]
  end

  # @return [String] device udid
  def udid
    @config[:udid]
  end

  # @param [AppiumServer] to, AppiumServer instance
  # @return [Selenium::WebDriver] driver instance
  def connect(to:)
    @driver = Appium::Driver.new({ caps: @capabilities,
                                   appium_lib: { port: to.appium_port } },
                                 false)
    @driver.start_driver
  end

  def disconnect
    @driver.driver_quit
  end
end
