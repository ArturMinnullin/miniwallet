#!/usr/bin/env ruby

require 'bundler'
require 'pry'
require 'bitcoin'
require 'warning'
require_relative 'lib/miniwallet'

Warning.ignore(/bitcoin.rb/)

Bundler.setup
Bitcoin.network = :testnet

cmd = ARGV.shift; cmdopts = ARGV
unless cmd
  puts optparse; exit
end

if File.exists?('private_key')
  privkey = File.read('private_key').strip
end

case cmd
when 'key'
  privkey = Miniwallet::Key.new.create
  File.write('private_key', privkey)

  puts 'Key saved in private_key'
when 'addr'
  k = Bitcoin::Key.new(privkey)

  puts k.addr
when 'balance'
  balance = Miniwallet::Balance.new(privkey).get

  puts "Balance: #{sprintf('%0.10f', balance)} ฿T"
when 'send'
  address = ARGV[0]
  amount = ARGV[1].to_f

  tx_id = Miniwallet::Sender.new(privkey, address).send(amount)
  puts "#{sprintf('%0.10f', amount)} ฿T sent to address #{address}: #{tx_id}"
else
  puts 'Error: Wrong command'
end
