# frozen_string_literal: true

# Module contains common methods for all modes
module CommonMethods
  def self.prepare_folder(config, udid)
    cfg = ConfigHelper.find_device_by_udid config, udid
    ADB.clear_folder udid
    ADB.push udid, cfg[:config][:opening][:folder]
  end

  def self.configure_connections(config, udid_list)
    connections = []
    udid_list.each do |udid|
      cfg = ConfigHelper.find_device_by_udid config, udid
      connections << { device: Device.new(cfg),
                       server: AppiumServer.new(udid) }
    end
    connections
  end

  def self.start_connections(connections)
    threads = []
    connections.each do |connection|
      threads << Thread.new(connection) do |conn|
        conn[:server].run
        sleep 2
        conn[:device].connect to: conn[:server]
      end
    end
    threads.each(&:join)
  end
end
