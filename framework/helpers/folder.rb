# frozen_string_literal: true

module Helper
  # Class for operations with file system
  class Folder
    # @param [String] path, Path to target folder
    # @param [Symbol] mode, Result mode :full/:short
    # @return [Array] List of files in target folder
    def self.files(path, mode: :full)
      files = []
      Dir.entries(path).each do |file|
        current_path = File.join path, file
        next unless File.file? current_path

        files << current_path if mode == :full
        files << file if mode == :short
      end
      files
    end

    # @param [String] path, Path to target folder
    # @param [Symbol] mode, Result mode :full/:short
    # @return [Array] List of folders in target folder
    def self.folders(path, mode: :full)
      folders = []
      Dir.entries(path).each do |folder|
        current_path = File.join path, folder
        next if File.file?(current_path) || %w[. ..].include?(folder)

        folders << current_path if mode == :full
        folders << folder if mode == :short
      end
      folders
    end
  end
end
