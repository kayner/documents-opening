# frozen_string_literal: true

# Class for extending adb functional
class ADBWrapper
  # @return [Array[String]] list of connected devices
  def self.devices
    split_n = `adb devices`.split("\n")
    split_n[1, split_n.count].map do |line|
      line.split("\t")[0]
    end
  end

  # @param [String] udid, Udid of device
  # @param [String] folder, Path to copying folder
  def self.push(udid, folder)
    `adb -s #{udid} push #{folder}/. /sdcard/OnlyOffice`
  end

  # @param [String] udid, Udid of device
  def self.clear_folder(udid)
    `adb -s #{udid} shell rm -rf /sdcard/OnlyOffice/*`
  end
end
