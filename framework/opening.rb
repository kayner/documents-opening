# frozen_string_literal: true

# Main opener class
class Opening
  include AppiumWrapper

  def initialize(connections, logger)
    @connections = connections
    @logger = logger
  end

  def open_on_device_section(driver)
    click driver: driver, id: ID::ON_BOARDING_SKIP_BTN
    click driver: driver, id: ID::NAVIGATION_ON_DEVICE_BTN
  end

  def open_file(driver, file)
    click driver: driver, id: ID::SEARCH_OPEN_BTN
    fill driver: driver, id: ID::SEARCH_FIELD, data: file
    click driver: driver, id: ID::FILE_NAME
  end

  def file_opened?(driver, time)
    element_exist? driver: driver, id: ID::EDITORS_ADD_BTN, time: time
  end

  def stop_file_opening(driver)
    hardback driver: driver
  end

  def close_file(driver)
    2.times { hardback driver: driver }
  end

  def update_on_device_section(driver)
    click driver: driver, id: 'menu_item_on_device'
  end

  def get_device_opening_dir(device)
    File.join device.config[:opening][:folder], 'open'
  end

  def get_device_opened_dir(device)
    File.join device.config[:opening][:folder], 'opened'
  end

  def move_opened_file(file, from, to)
    FileUtils.move "#{from}/#{file}", "#{to}/#{file}"
  end

  def mode_action(device, file)
    mode = device.config[:opening][:mode].to_sym
    case mode
    when :smoke then nil
    when :screenshot then screenshot_mode(device, file)
    when :export then export_mode(device, file)
    else raise ArgumentError
    end
  end

  def screenshot_mode(device, file)
    path = File.join device.config[:screenshot][:folder], "#{file}.png"
    device.driver.screenshot path
  end

  def export_mode(device, file)
    export_list = device.config[:export][:extensions]
    document = Editor::Type.factory device, file
    export_list.each do |extension|
      document.open_settings
      document.export extension
      sleep 3
    end
  end

  def create_thread(device_class)
    Thread.new(device_class) do |device|
      driver = device.driver
      opening_dir = get_device_opening_dir device
      opened_dir = get_device_opened_dir device

      open_on_device_section driver

      Helper::Folder.files(opening_dir, mode: :short).each do |file|
        open_file driver, file

        if file_opened?(driver, 120)
          move_opened_file file, opening_dir, opened_dir
          sleep 3

          mode_action device, file

          close_file driver
          sleep 3
          close_keyboard driver: driver

          update_on_device_section driver
        else
          stop_file_opening driver
        end
      end
    end
  end

  def start
    @connections.each(&:start)
    threads = @connections.map { |conn| create_thread conn.device }
    threads.each(&:join)
    @connections.each(&:stop)
  end
end
