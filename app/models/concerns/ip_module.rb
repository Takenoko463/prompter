require 'ipaddress'
module IpModule
  extend ActiveSupport::Concern

  def validate_ip_format?(ip)
    IPAddress(ip)
    true
  rescue ArgumentError
    false
  end
end
