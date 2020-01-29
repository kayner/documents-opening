# frozen_string_literal: true

module EditorModel
  # Class for control document editor behavior
  class Document < FileModel::Base
    def export(extension)
      settings
      click driver: @driver, id: ID::EXPORT_DOCUMENT_BTN
      click driver: @driver, id: export_extension_to_id(extension)
    end

    def export_extension_to_id(extension)
      case extension
      when 'docx' then ID::EXPORT_DOCUMENT_TO_DOCX
      when 'pdf' then ID::EXPORT_DOCUMENT_TO_PDF
      when 'rtf' then ID::EXPORT_DOCUMENT_TO_RTF
      when 'odf' then ID::EXPORT_DOCUMENT_TO_ODF
      else raise ArgumentError "Unknown extension: #{extension}"
      end
    end
  end
end
