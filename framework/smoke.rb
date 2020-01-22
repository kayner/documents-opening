# frozen_string_literal: true

# Opening method
class Smoke
  include AppiumExtension

  def initialize(connections, logger)
    @connections = connections
    @logger = logger
  end

  def threads
    threads = []
    @connections.each do |connection|
      threads << Thread.new(connection[:device]) do |device|
        driver = device.driver

        click driver: driver, id: 'on_boarding_panel_skip_button'
        click driver: driver, id: 'menu_item_on_device'

        Dir.entries(device.config[:config][:opening][:folder]).each do |file|
          next if %w[. ..].include? file

          click driver: driver, id: 'search_button'
          fill driver: driver, id: 'search_src_text', data: file
          click driver: driver, id: 'list_explorer_file_name'

          if element(driver: driver, id: 'toolbarAddButton', time: 120).nil?
            @logger.warn "[#{device.udid}] Interrupted by timeout #{file}"
            hardback driver: driver
          else
            driver.screenshot "#{device.config[:config][:screenshot][:folder]}/#{file}.png"
            @logger.info "[#{device.udid}] Success #{file}"
            2.times { hardback driver: driver }
            sleep 3
          end

          close_keyboard driver: driver
          click driver: driver, id: 'menu_item_on_device'
        end

        sleep 5
        device.disconnect
        @logger.info "[#{device.udid}] Disconnected from the #{connection[:server]}"
      end
    end
    threads
  end
end
