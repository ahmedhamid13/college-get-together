# frozen_string_literal: true

class Ahoy::Visit < ApplicationRecord
  self.table_name = "ahoy_visits"

  has_many :events, class_name: "Ahoy::Event"
  belongs_to :user, optional: true

  before_save :set_location

  UNVALIDATED_IP_ADDRESSES = ["::1", "localhost:3000", "localhost", "127.0.0.1"]

  def set_location
    if self.longitude && self.latitude
      geo = Geocoder.search([self.longitude.to_f, self.latitude.to_f]).first
    elsif self.ip.to_s && IPAddress.valid?(self.ip.to_s)
      geo = Geocoder.search(self.ip.to_s).first
      if geo&.coordinates&.any?
        self.latitude = geo.coordinates[0].to_f
        self.longitude = geo.coordinates[1].to_f
      end
    end
    self.location = geo if geo
  end

  before_save :set_device
  def set_device
    if self.user_agent
      client = DeviceDetector.new(self.user_agent.to_s)
      # browser = Browser.new(self.user_agent.to_s, accept_language: "en-us")
      browser = Browser.new(self.user_agent.to_s)
      device = {}

      if client
        device[:name] = client.name # => 'Chrome'
        device[:client_full_version] = client.full_version # => '30.0.1599.69'
        device[:os_name] = client.os_name # => 'Windows'
        device[:os_family] = client.os_family
        device[:os_full_version] = client.os_full_version # => '8'

        # For many devices, you can also query the device name (usually the model name)
        device[:device_name] = client.device_name # => 'iPhone 5'
        # Device types can be one of the following: desktop, smartphone, tablet, console,
        # portable media player, tv, car browser, camera
        device[:device_type] = client.device_type # => 'smartphone'
        device[:device_brand] = client.device_brand

        device[:bot_name] = client.bot_name
      end
      if browser
        device[:browser_full_version] = browser.full_version
        device[:browser_version] = browser.version
        device[:browser_device_id] = browser.device.id
        device[:platform] = browser.platform
        device[:platform_id] = browser.platform.id
        device[:platform_name] = browser.platform.name
        device[:platform_version] = browser.platform.version  # e.g. 9 (for iOS9)
        language = browser.accept_language.first
        if language
          device[:language_code] = language.code
          #=> "en"
          device[:language_region] = language.region
          #=> "US"
          device[:language_full] = language.full
          #=> "en-US"
          device[:language_quality] = language.quality
          #=> 1.0
          device[:language_name] = language.name
        end
      end
      self.device = device if client || browser
    end
  end
end
