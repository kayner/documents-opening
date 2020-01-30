# frozen_string_literal: true

module Helper
  # Class for working with config file
  class Config
    attr_reader :path, :config

    # @param [String] path, Path to config
    # @return [ConfigHelper] instance
    def initialize(path)
      @path = path
      @config = JSON.parse File.read(path), symbolize_names: true
    end

    # @return [Hash] Appium capabilities
    def capabilities
      @config[:capabilities]
    end

    # @return [String] List of devices udids
    def udids
      @config[:devices].map { |device| device[:udid] }
    end

    # @param [String] udid, Target device udid
    # @return [Hash] Target device config
    def by_udid(udid)
      @config[:devices].each do |device|
        return device if device[:udid] == udid
      end
    end

    # @param [String] name, Target device name
    # @return [Hash] Target device config
    def by_name(name)
      @config[:devices].each do |device|
        return device if device[:udid] == name
      end
    end
  end
end
