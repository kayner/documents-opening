# frozen_string_literal: true

# Class for wrapping adb functional
class ADB
  def self.devices
    `#{Static::ADB_PATH} devices`.split("\n")[1..-1].map do |line|
      line.split("\t").first
    end
  end

  def self.push_folder(udid, path_to_folder)
    `#{Static::ADB_PATH} -s #{udid} push #{path_to_folder}/. /sdcard/Onlyoffice`
  end

  def self.clear_folder(udid)
    `#{Static::ADB_PATH} -s #{udid} shell rm -rf /sdcard/Onlyoffice/*`
  end

  def self.remove_file(udid, file)
    `#{Static::ADB_PATH} -s #{udid} shell rm /sdcard/Onlyoffice/#{file}`
  end
end
