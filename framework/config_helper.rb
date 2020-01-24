# frozen_string_literal: true

require 'json'

# Class for reading data from configs
class ConfigHelper
  # @param [String] path, Path to config
  # @return [Hash] parsed config
  def self.parse(path)
    JSON.parse File.read(path), symbolize_names: true
  end

  # @param [Hash] config, Parsed config
  # @param [String] value, Device udid
  # @return [Hash] parsed device config
  def self.find_device_by_udid(config, value)
    config[:devices].each do |device|
      return device if device[:udid] == value
    end
  end

  # @param [Hash] config, Parsed config
  # @return [Array[String]] List of connected devices udids
  def self.udids(config)
    config[:devices].map do |device|
      device[:udid]
    end
  end
end
