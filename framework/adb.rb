# frozen_string_literal: true

# Class for extending adb functional
class ADB
  def self.devices
    list = []
    split_n = `adb devices`.split("\n")
    split_n[1, split_n.count].each do |line|
      list << line.split("\t")[0]
    end
    list
  end

  def self.push(udid, folder)
    `adb -s #{udid} push #{folder}/. /sdcard/OnlyOffice`
  end

  def self.clear_folder(udid)
    `adb -s #{udid} shell rm -rf /sdcard/OnlyOffice/*`
  end
end
