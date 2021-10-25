#!/usr/bin/env ruby

require 'bundler'
require_relative 'lib/miniwallet'

Bundler.setup

cmd = ARGV.shift
exit unless cmd

case cmd
when 'key'
  Miniwallet::Key.create
  puts 'Key is generated'
when 'balance'
  balance = Miniwallet::Balance.get
  puts "Balance: #{balance} ฿T"
when 'send'
  SendAmount.call
else
  puts 'Error: Wrong command'
end
