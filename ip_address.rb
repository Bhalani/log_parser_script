class IpAddress < FindOrAddUtil
  @@ip_addresses = []
  class << self
    def list
      @@ip_addresses
    end

    def find(ip)
      @@ip_addresses.select { |ip_address| ip_address.ip_address == ip }.first
    end
  end

  def initialize(ip_address)
    @ip_address = ip_address
  end

  attr_accessor :ip_address
end
