# frozen_string_literal: true

module FileModel
  # Base FileModel class
  class Base
    def initialize(driver, extension)
      @driver = driver
      @extension = extension
    end

    def settings
      click driver: @driver, id: ID::EDITORS_SETTINGS_BTN
    end

    def export
      raise NotImplementedError
    end

    def export_extension_to_id
      raise NotImplementedError
    end
  end
end
