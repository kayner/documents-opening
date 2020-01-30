# frozen_string_literal: true

module Helper
  # Class for creating dumps
  class Dump
    # @param [String] path, Path for saving dumps
    # @return [DumpCreator] instance
    def initialize(path)
      @path = path
    end

    # @param [String] path, Path for dumping
    # @param [String] dump_path, Path for saving dump
    def perform(path, dump_path)
      FileUtils.copy path, dump_path
    end

    # @param [Array[String]] path_list, List of paths for dumping
    def perform_each(path_list)
      target_path = generate_dump_path
      path_list.each { |path| perform(path, target_path) }
    end

    # @return [String] Path to folder for dump save
    def generate_dump_path
      folder_name = Time.now.strftime '%Y-%m-%d %H:%M:%S'
      File.join @path, folder_name
    end
  end
end
