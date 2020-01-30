# frozen_string_literal: true

require_relative '../../wrappers/appium_wrapper'

module Editor
  # Base editors class
  class Base
    include AppiumWrapper

    def initialize(device)
      @driver = device.driver
    end

    def open_settings
      click driver: @driver, id: ID::EDITORS_SETTINGS_BTN
    end
  end
end
