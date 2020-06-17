# frozen_string_literal: true

require_relative 'requirements'

# Main opener class
class Opening
  attr_reader :config, :fails, :open_path, :opened_path, :not_opened_path,
              :screenshots_path, :server, :driver

  include AppiumExtender

  def initialize(config)
    @config = config
    @fails = 0

    fs_device_name = @config[:capabilities][:deviceName].split(' ').join('')
    files_path = File.join Static::Path::FILES_PATH, fs_device_name

    @open_path = File.join files_path, 'to_open'
    @opened_path = File.join files_path, 'opened'
    @not_opened_path = File.join files_path, 'not_opened'
    @screenshots_path = File.join Static::Path::SCREENSHOTS_PATH, fs_device_name
  end

  def start
    @server = Server.new @config[:capabilities][:udid], @config[:appium_port],
                         @config[:system_port]
    Appium::Driver.new caps: @config[:capabilities],
                       appium_lib: { port: @config[:appium_port] }
    Appium.promote_appium_methods [Object]
    @server.run
    @driver.start_driver
    open
  end

  def restart
    stop
    start
  end

  def stop
    @driver.driver_quit
  end

  def skip_onboarding
    click id: Static::Id::ONBOARDING_SKIP
  end

  def open_on_device
    click id: Static::Id::ON_DEVICE_SECTION
  end

  def find_file(file_name)
    click id: Static::Id::SEARCH_OPEN
    fill id: Static::Id::SEARCH_FIELD, data: file_name
  end

  def open_file
    click id: Static::Id::FILE_NAME
  end

  def file_opened?(time = 120)
    element_exist? id: Static::Id::EDITORS_SETTINGS, time: time
  end

  def move_file(file_name, status)
    case status
    when :opened
      FileUtils.move "#{@open_path}/#{file_name}", "#{@opened_path}/#{file_name}"
    when :not_opened
      FileUtils.move "#{@open_path}/#{file_name}", "#{@not_opened_path}/#{file_name}"
    else
      raise ArgumentError, 'Undefined status'
    end
  end

  def close_file
    2.times { hardback }
  end

  def stop_file_opening
    hardback
  end

  def open
    begin
      skip_onboarding
      FS.files(@open_path, mode: FS::SHORT).each do |file_name|
        open_on_device
        find_file file_name
        open_file
        if file_opened?
          move_file file_name, :opened
          sleep 3
          screenshot "#{@screenshots_path}/#{file_name}.png"
          close_file
        else
          move_file file_name, :not_opened
          stop_file_opening
        end
        hide_keyboard if is_keyboard_shown
      end
    rescue StandardError => e
      puts e
      @fails += 1
      if @fails < @config[:failures]
        restart
      else
        stop
      end
    end
  end
end
