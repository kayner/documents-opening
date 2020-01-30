# frozen_string_literal: true

require_relative 'framework/requirements_manager'

config_reader = Helper::Config.new File.join('config', 'config.json')
capabilities = config_reader.capabilities
root_folders = %w[files screenshots logs dumps]

Selenium::WebDriver.logger.level = :error

namespace :prepare do
  task :folders do
    puts 'Creating folders in project root'
    FileUtils.mkdir_p root_folders

    puts 'Creating subfolders for files'
    config[:devices].each do |device|
      FileUtils.mkdir_p device[:config][:opening][:folder] + '/open'
      FileUtils.mkdir_p device[:config][:opening][:folder] + '/opened'
    end

    puts 'Creating subfolders for screenshots'
    config[:devices].each do |device|
      FileUtils.mkdir_p device[:config][:screenshot][:folder]
    end
  end

  task :check do
    root_folders.each do |root_folder|
      puts "#{root_folder} : #{File.exist? root_folder}"
    end

    puts "config.json : #{File.file? 'config/config.json'}"
  end
end

task :status do
  ADBWrapper.devices.each do |udid|
    config[:devices].each do |device|
      if device[:udid] == udid
        puts "#{device[:name]} mode: #{device[:config][:opening][:mode]}"
      end
    end
  end
end

task :run do
  logger = LoggerWrapper.new Logger::INFO
  connected_device = ADBWrapper.devices
  connections = []

  connected_device.each do |udid|
    device_config = config_reader.by_udid udid
    device = Device.new device_config, capabilities
    connections << Connection.new(device)

    ADBWrapper.clear_folder udid
    ADBWrapper.push udid, device.config[:opening][:folder] + '/open'
  end

  runner = Opening.new connections, logger
  runner.start
end
