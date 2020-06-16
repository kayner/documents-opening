# frozen_string_literal: true

require_relative 'framework/opening'

config = JSON.parse File.read('config.json'), symbolize_names: true
project_folders = %w[files screenshots logs apk]

Selenium::WebDriver.logger.level = :error

namespace :prepare do
  task :folders do
    FileUtils.mkdir_p project_folders

    config[:devices].each do |device|
      FileUtils.mkdir_p File.join('files', device[:name].split(' ').join(''), 'to_open')
      FileUtils.mkdir_p File.join('files', device[:name].split(' ').join(''), 'opened')
      FileUtils.mkdir_p File.join('files', device[:name].split(' ').join(''), 'not_opened')
    end

    config[:devices].each do |device|
      FileUtils.mkdir_p File.join('screenshots', device[:name].split(' ').join(''))
    end
  end
end

namespace :run do
  desc 'Run test on all connected devices and emulators'
  task :all do
    ADB.devices.each do |udid|
      `gnome-terminal -- rake run:single udid=#{udid}`
    end
  end

  desc 'Desc'
  task :single do
    begin
      device_config = {}
    config[:devices].each do |device|
      device_config = device if device[:udid] == ENV['udid']
    end
    device_config[:capabilities] = config[:capabilities]
    device_config[:capabilities][:udid] = device_config[:udid]
    device_config[:capabilities][:deviceName] = device_config[:name]
    device_config[:failures] = config[:failures]
    device_config[:mode] = config[:mode]

    opener = Opening.new device_config
    ADB.clear_folder ENV['udid']
    ADB.push_folder ENV['udid'], opener.open_path
    opener.start
    opener.stop
    rescue => exception
      puts exception
    ensure
    puts 'Press any key for exit...'
    STDIN.gets
    end
  end
end
