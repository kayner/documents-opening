# frozen_string_literal: true

module Editor
  # Class for working with spreadsheets
  class Spreadsheet < Editor::Base
    def export(extension)
      open_settings
      click driver: @driver, id: ID::EXPORT_SPREADSHEET_BTN
      click driver: @driver, id: export_extension_to_id(extension)
    end

    def export_extension_to_id(extension)
      case extension
      when 'xlsx' then ID::EXPORT_SPREADSHEET_TO_XLSX
      when 'pdf' then ID::EXPORT_SPREADSHEET_TO_PDF
      when 'csv' then ID::EXPORT_SPREADSHEET_TO_CSV
      when 'ods' then ID::EXPORT_SPREADSHEET_TO_ODS
      else raise ArgumentError "Unknown extension: #{extension}"
      end
    end
  end
end
