# frozen_string_literal: true

module Helper
  # Class for zipping folders
  class ZIPHelper
    # @param [String] folder_path, Path to folder for zipping
    # @param [Object] zip_path, Path for saving zip
    def self.compress(folder_path, zip_path)
      Zip::File.open(zip_path, Zip::File::CREATE) do |zipfile|
        Dir[File.join(folder_path, '*')].each do |file|
          zipfile.add(file.sub(folder_path + '/', ''), file)
        end
      end
    end
  end
end
