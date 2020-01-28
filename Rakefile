# frozen_string_literal: true

require_relative 'framework/requirements_manager'

config = ConfigHelper.parse File.join('config', 'config.json')
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

task :smoke do
  log_path = "logs/#{Time.now.strftime '%Y-%m-%d %H:%M:%S'}.txt"
  logger = Logger.new log_path
  logger.level = Logger::INFO
  logger.datetime_format = '%Y-%m-%d %H:%M:%S'
  logger.info config

  devices = ADBWrapper.devices
  logger.info "Devices: #{devices}"

  connections = []
  devices.each do |udid|
    cfg = ConfigHelper.find_device_by_udid config, udid
    ADBWrapper.clear_folder udid
    ADBWrapper.push udid, cfg[:config][:opening][:folder] + '/open'
    logger.info "Prepared folders for #{udid}"

    connections << { device: Device.new(cfg),
                     server: AppiumServer.new(udid) }
  end
  sleep 5

  connections.each do |connection|
    connection[:server].run
    sleep 2
    connection[:device].connect to: connection[:server]
    logger.info "Connection opened #{connections}"
  end

  threads = []
  connections.each do |connection|
    threads << OpeningMode.factory(connection[:device], logger)
  end
  threads.each(&:join)
end
