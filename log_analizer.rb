class LogAnalizer
  def initialize(file)
    @file = file
  end

  def parse_log
    File.readlines(@file).each do |line|
      url, ip_address = line.split(' ')
      page = Page.find_or_add(url) 
      page.add_view(IpAddress.find_or_add(ip_address))
    end
  end

  def print_results
    print_view_count_per_page
    puts "\n============================"
    print_distinct_view_count_per_page
    puts "\n============================"
    print_all_urls_count
    puts "\n============================"
    print_all_uniq_urls_count
    puts "\n============================"
    print_all_uniq_requester_count
    puts "\n============================"
  end

  def print_view_count_per_page
    puts "\nTotal View Counts"
    Page.order_by_view_count_decending.each do |page|
      puts "#{page.url} #{page.view_count}"
    end
  end

  def print_distinct_view_count_per_page
    puts "\nSingle time Visitor Counts"
    Page.order_by_single_viewer_decending.each do |page|
      puts "#{page.url} #{page.one_time_viewers_count}"
    end
  end

  def print_all_urls_count
    puts "\nPrint all URLs from log"
    puts Page.list.map(&:log_count).flatten.sum
  end

  def print_all_uniq_urls_count
    puts "\nPrint Uniq URLs from logs"
    puts Page.list.count
  end

  def print_all_uniq_requester_count
    puts "\nPrint Uniq URLs from logs"
    puts IpAddress.list.count
  end
end
