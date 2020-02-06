# frozen_string_literal: true

# Main opener class
class Opening
  include AppiumWrapper

  # @param [Array[Device]] devices, Configured devices
  # @param [LoggerWrapper] logger, Instance of LoggerWrapper class
  # @return [Opening] instance
  def initialize(devices, logger)
    @devices = devices
    @logger = logger
  end

  # @param [Appium::Driver] driver, instance of Appium Driver
  def open_on_device_section(driver)
    click driver: driver, id: ID::ON_BOARDING_SKIP_BTN
    click driver: driver, id: ID::NAVIGATION_ON_DEVICE_BTN
  end

  # @param [Appium::Driver] driver, instance of Appium Driver
  # @param [String] file, File name for opening
  def open_file(driver, file)
    click driver: driver, id: ID::SEARCH_OPEN_BTN
    fill driver: driver, id: ID::SEARCH_FIELD, data: file
    click driver: driver, id: ID::FILE_NAME
  end

  # @param [Appium::Driver] driver, instance of Appium Driver
  # @param [Integer] time, Time for checking opening status
  # @return [Boolean] opening status
  def file_opened?(driver, time)
    element_exist? driver: driver, id: ID::EDITORS_ADD_BTN, time: time
  end

  # @param [Appium::Driver] driver, instance of Appium Driver
  def stop_file_opening(driver)
    hardback driver: driver
  end

  # @param [Appium::Driver] driver, instance of Appium Driver
  def close_file(driver)
    2.times { hardback driver: driver }
  end

  # @param [Appium::Driver] driver, instance of Appium Driver
  def update_on_device_section(driver)
    click driver: driver, id: 'menu_item_on_device'
  end

  # @param [Device] device, Device instance
  # @return [String] path to folder with files for opening
  def get_device_opening_dir(device)
    File.join device.config[:opening][:folder], 'open'
  end

  # @param [Device] device, Device instance
  # @return [String] path to folder with opened files
  def get_device_opened_dir(device)
    File.join device.config[:opening][:folder], 'opened'
  end

  # @param [String] file, file name for moving
  # @param [String] from, path from
  # @param [String] to, path to
  def move_opened_file(file, from, to)
    FileUtils.move "#{from}/#{file}", "#{to}/#{file}"
  end

  # @param [Device] device, Device instance
  # @param [String] file, file name
  def mode_action(device, file)
    mode = device.config[:opening][:mode].to_sym
    case mode
    when :smoke then nil
    when :screenshot then screenshot_mode(device, file)
    when :export then export_mode(device, file)
    else raise ArgumentError
    end
  end

  # @param [Device] device, Device instance
  # @param [String] file, file name
  def screenshot_mode(device, file)
    path = File.join device.config[:screenshot][:folder], "#{file}.png"
    device.driver.screenshot path
  end

  # @param [Device] device, Device instance
  # @param [String] file, file name
  def export_mode(device, file)
    export_list = device.config[:export][:extensions]
    document = Editor::Type.factory device, file
    export_list.each do |extension|
      document.open_settings
      document.export extension
      sleep 3
      60.times do
        break if elements(driver: device.driver, id: ID::EXPORT_LOADER).count.zero?

        sleep 1
      end
      sleep 3
    end
  end

  # @param [Device] device_class, Device instance
  def create_thread(device_class)
    Thread.new(device_class) do |device|
      driver = device.driver
      opening_dir = get_device_opening_dir device
      opened_dir = get_device_opened_dir device

      open_on_device_section driver

      Helper::Folder.files(opening_dir, mode: :short).each do |file|
        @logger.info device.name, "started opening #{file}"
        open_file driver, file

        if file_opened?(driver, 120)
          @logger.info device.name, "successful opening #{file}"
          move_opened_file file, opening_dir, opened_dir
          sleep 3

          mode_action device, file

          close_file driver
          sleep 3
          close_keyboard driver: driver

          update_on_device_section driver
        else
          @logger.warn device.name, "failed opening #{file}"
          stop_file_opening driver
          move_opened_file file, opening_dir, opened_dir
        end
      end
    end
  end

  def start
    @devices.each do |device|
      server_instance = Server.new device.udid
      server_instance.run
      sleep 2
      device.connect to: server_instance
    end
    threads = @devices.map { |device| create_thread device }
    threads.each(&:join)
    @devices.each(&:disconnect)
  end
end
