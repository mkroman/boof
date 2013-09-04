#!/usr/bin/env ruby
# encoding: utf-8

$:.unshift File.dirname(__FILE__) + '/../library'
require 'boof'

ARGV.each do |filename|
  File.open filename do |file|
    region = Boof::Region.read file
    blocks = []

    begin
      loop do
        block = Boof::Block.read file
        blocks << block

        if block.last?
          break
        end
      end
    rescue => exception
      puts "#{exception}"
    ensure
      blocks.each do |block|
        block_name = block.address.to_i.to_s 16

        puts "Dumping block #{block_name} …"

        File.open block_name, 'w+' do |output|
          output.write block.data
        end
      end
    end
  end
end