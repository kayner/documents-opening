# frozen_string_literal: true

# Opening mode for creating screenshot for each file
class Screenshot
  # @param [Hash] device, Device config
  # @param [Logger] logger, Logger
  # @return [Smoke] instance
  def initialize(device, logger)
    @device = device
    @logger = logger
  end

  # @return [Thread] thread for running on @device
  def thread
    Thread.new(@device) do |device|
      driver = device.driver
      opening_folder = File.join device.config[:opening][:folder], 'open'
      opened_folder = File.join device.config[:opening][:folder], 'opened'
      screenshot_folder = device.config[:screenshot][:folder]

      click driver: driver, id: 'on_boarding_panel_skip_button'
      click driver: driver, id: 'menu_item_on_device'

      puts opening_folder
      FileHelper.files(opening_folder, mode: :short).each do |file|
        click driver: driver, id: 'search_button'
        fill driver: driver, id: 'search_src_text', data: file
        click driver: driver, id: 'list_explorer_file_name'

        if element(driver: driver, id: 'toolbarAddButton', time: 120).nil?
          @logger.warn "[#{device.udid}] Interrupted by timeout #{file}"
          hardback driver: driver
        else
          FileUtils.move "#{opening_folder}/#{file}", "#{opened_folder}/#{file}"
          sleep 3
          driver.screenshot File.join(screenshot_folder, "#{file}.png")
          @logger.info "[#{device.udid}] Success #{file}"
          2.times { hardback driver: driver }
          sleep 3
        end

        close_keyboard driver: driver
        click driver: driver, id: 'menu_item_on_device'
      end

      sleep 5
      device.disconnect
    end
  end
end
