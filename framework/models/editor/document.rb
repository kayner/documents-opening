# frozen_string_literal: true

module Editor
  # Class for working with documents
  class Document < Editor::Base
    def export(extension)
      click driver: @driver, id: ID::EXPORT_DOCUMENT_BTN

      click driver: @driver, id: export_extension_to_id(extension)
    end

    def export_extension_to_id(extension)
      case extension
      when 'docx' then ID::EXPORT_DOCUMENT_TO_DOCX
      when 'pdf' then ID::EXPORT_DOCUMENT_TO_PDF
      when 'rtf' then ID::EXPORT_DOCUMENT_TO_RTF
      when 'odt' then ID::EXPORT_DOCUMENT_TO_ODT
      end
    end
  end
end
