#!/usr/bin/env ruby

require 'bundler'
require 'pry'
require_relative 'lib/fetch_balance'
require_relative 'lib/generate_key'
require_relative 'lib/send_amount'

Bundler.setup

cmd = ARGV.shift
exit unless cmd

case cmd
when 'balance'
  balance = FetchBalance.call('ss')
  puts "Balance: #{balance} ฿T"
when 'key'
  GenerateKey.call
when 'send'
  SendAmount.call
else
  puts 'Error: Wrong command'
end
