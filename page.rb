class Page < FindOrAddUtil
  @@total_pages = []

  class << self
    def find_or_add(url)
      super { |object| object.log_count += 1 }
    end

    def list
      @@total_pages
    end

    def sorted_desc_list
      @@total_pages.sort_by(&:url).reverse
    end

    def find(url)
      @@total_pages.select { |page| page.url == url }.first
    end

    def order_by_view_count_decending
      order_by_view_count.reverse
    end

    def order_by_single_viewer_decending
      order_by_single_viewer_count.reverse
    end

    def order_by_view_count
      sorted_desc_list.sort_by!(&:view_count)
    end

    def order_by_single_viewer_count
      sorted_desc_list.sort_by!(&:one_time_viewers_count)
    end
  end

  def initialize(url)
    @url = url
    @ip_addresses = []
    @log_count = 1
  end

  def match?(url)
    @url == url
  end

  def one_time_viewers
    viewers_occurance.select do |ip, occurance| 
      occurance == 1
    end
  end

  def viewers_occurance
    @ip_addresses.reduce Hash.new(0) do |occurance, ip|
      occurance[ip] += 1
      occurance
    end
  end

  def one_time_viewers_count
    one_time_viewers.count
  end

  def add_view(ip_address)
    @ip_addresses.push(ip_address)
  end

  def view_count
    @ip_addresses.count
  end

  attr_accessor :log_count, :url, :log_count
end