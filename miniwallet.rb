#!/usr/bin/env ruby

require 'bundler'
require_relative 'lib/fetch_balance'
require_relative 'lib/generate_key'
require_relative 'lib/send_amount'

Bundler.setup

cmd = ARGV.shift
exit unless cmd

case cmd
when 'balance'
  FetchBalance.call
when 'key'
  GenerateKey.call
when 'send'
  SendAmount.call
else
  puts 'Wrong command'
end
