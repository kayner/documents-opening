# frozen_string_literal: true

# Class for control logger behavior
class LoggerWrapper
  attr_reader :instance, :path

  # @param [Integer] level, Minimal level for writing
  # @return [LoggerWrapper] instance
  def initialize(level = Logger::INFO)
    @path = "logs/#{Time.now.strftime '%Y-%m-%d %H:%M:%S'}.txt"
    @instance = Logger.new @path
    @instance.level = level
    @instance.datetime_format = '%Y-%m-%d %H:%M:%S'
  end

  # @param [String] device, Device tag
  # @param [Object] message, Message for writing
  def info(device, message)
    @instance.info template(device, message)
  end

  # @param [String] device, Device tag
  # @param [Object] message, Message for writing
  def warn(device, message)
    @instance.warn template(device, message)
  end

  # @param [String] device, Device tag
  # @param [Object] message, Message for writing
  def template(device, message)
    "#{device}: #{message}"
  end
end
