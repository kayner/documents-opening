# frozen_string_literal: true

# Class for device control
class Device
  attr_reader :driver, :config

  def initialize(config)
    @config = config
    @capabilities = ConfigHelper.parse('config/config.json')[:capabilities]
    @capabilities[:deviceName] = config[:name]
    @capabilities[:udid] = config[:udid]
    @driver = nil
  end

  def name
    @config[:name]
  end

  def udid
    @config[:udid]
  end

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
