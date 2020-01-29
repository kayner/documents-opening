# frozen_string_literal: true

# Module for control editors behavior
module EditorModel
  def self.factory(driver, ext)
    docs = %w[docx doc txt rtf odt]
    tables = %w[xlsx xls csv ods]
    slides = %w[pptx ppt odp]
    return EditorModel::Document.new(driver, ext) if docs.include? ext
    return EditorModel::Spreadsheet.new(driver, ext) if tables.include? ext
    return EditorModel::Presentation.new(driver, ext) if slides.include? ext
  end
end
