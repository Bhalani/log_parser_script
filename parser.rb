#!/usr/bin/env ruby

require_relative 'find_or_add_util'
require_relative 'page'
require_relative 'ip_address'

module Parser
  autoload(:LogAnalizer, './log_analizer.rb')

  log_analizer = LogAnalizer.new(ARGV[0])
  log_analizer.parse_log
  log_analizer.print_results
end
