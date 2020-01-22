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
      FileUtils.mkdir_p device[:config][:opening][:folder]
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

namespace :run do
  task :smoke do
    log_path = "logs/#{Time.now.strftime '%Y-%m-%d %H:%M:%S'}.txt"
    logger = Logger.new log_path
    logger.level = Logger::INFO
    logger.datetime_format = '%Y-%m-%d %H:%M:%S'
    logger.info config

    devices = ADB.devices
    logger.info "Devices: #{devices}"

    devices.each do |udid|
      CommonMethods.prepare_folder config, udid
      logger.info "Prepared folders for #{udid}"
    end
    sleep 5

    connections = CommonMethods.configure_connections config, devices
    CommonMethods.start_connections connections
    logger.info "Connections opened for #{connections}"

    threads = Smoke.new(connections, logger).threads
    threads.each(&:join)
  end
end
