# frozen_string_literal: true

# Opening mode for export files and creating screenshots
class ExportMode
  include AppiumExtension

  # @param [Hash] device, Device config
  # @param [Logger] logger, Logger
  # @return [ExportMode] instance
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

      click driver: driver, id: ID::ON_BOARDING_SKIP_BTN
      click driver: driver, id: ID::NAVIGATION_ON_DEVICE_BTN

      puts opening_folder
      FileHelper.files(opening_folder, mode: :short).each do |file|
        click driver: driver, id: ID::SEARCH_OPEN_BTN
        fill driver: driver, id: ID::SEARCH_FIELD, data: file
        click driver: driver, id: ID::FILE_NAME

        if element(driver: driver, id: ID::EDITORS_ADD_BTN, time: 120).nil?
          @logger.warn "[#{device.udid}] Interrupted by timeout #{file}"
          hardback driver: driver
        else
          FileUtils.move "#{opening_folder}/#{file}", "#{opened_folder}/#{file}"
          sleep 3
          extension = File.extname(file).strip.downcase[1..-1]
          model = EditorModel.factory driver, extension
          device.config[:export][:extensions].each do |ext|
            model.settings
            model.export ext
          end
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
