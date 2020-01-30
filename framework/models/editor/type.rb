# frozen_string_literal: true

module Editor
  # Class definition editor type
  class Type
    def self.factory(driver, name)
      extension = File.extname(name).strip.downcase[1..-1]
      docs = %w[docx doc txt rtf odt]
      tables = %w[xlsx xls csv ods]
      slides = %w[pptx ppt odp]
      return Editor::Document.new(driver) if docs.include? extension
      return Editor::Spreadsheet.new(driver) if tables.include? extension
      return Editor::Presentation.new(driver) if slides.include? extension
    end
  end
end
