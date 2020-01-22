# frozen_string_literal: true

require 'json'

# Class for reading data from configs
class ConfigHelper
  def self.parse(path)
    JSON.parse File.read(path), symbolize_names: true
  end

  def self.find_device_by_udid(config, value)
    config[:devices].each do |device|
      return device if device[:udid] == value
    end
  end

  def self.udids(config)
    udids = []
    config[:devices].each do |device|
      udids << device[:udid]
    end
    udids
  end
end
