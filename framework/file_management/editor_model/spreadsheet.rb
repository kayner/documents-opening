# frozen_string_literal: true

module EditorModel
  # Class for control spreadsheet editor behavior
  class Spreadsheet < FileModel::Base
    def export(extension)
      settings
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
