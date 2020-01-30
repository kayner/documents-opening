# frozen_string_literal: true

module Editor
  # Class for working with presentations
  class Presentation < Editor::Base
    def export(extension)
      open_settings
      click driver: @driver, id: ID::EXPORT_PRESENTATION_BTN
      click driver: @driver, id: export_extension_to_id(extension)
    end

    def export_extension_to_id(extension)
      case extension
      when 'pptx' then ID::EXPORT_PRESENTATION_TO_PPTX
      when 'pdf' then ID::EXPORT_PRESENTATION_TO_PDF
      when 'odp' then ID::EXPORT_PRESENTATION_TO_ODP
      else raise ArgumentError "Unknown extension: #{extension}"
      end
    end
  end
end
