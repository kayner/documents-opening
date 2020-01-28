# frozen_string_literal: true

require_relative 'opening_mode/screenshot'
require_relative 'opening_mode/smoke'

# Class for controlling the launch of a configurable open mode
class OpeningMode
  # @param [Hash] device, Device config
  # @param [Logger] logger, Logger
  # @return [Thread] thread for running on device
  def self.factory(device, logger)
    mode = device.config[:opening][:mode].to_sym
    case mode
    when :smoke then Smoke.new(device, logger).thread
    when :screenshot then Screenshot.new(device, logger).thread
    when :export then Export.new(device, logger).thread
    else raise ArgumentError "Unknown mode: #{mode}"
    end
  end
end
