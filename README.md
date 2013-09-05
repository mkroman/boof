boof
====

Boof is a Ruby library to read and dissect WinCE binary files.

Usage
=====
    File.open "my-file.bin" do |file|
      region = Boof::Region.read file
      blocks = []

      loop do
        block = Boof::Block.read file
        blocks << block
        
        if block.last?
          # We've read the entire file now.
          break
        end
      end

      blocks.each do |block|
        puts "Block: #{block.address.to_i.to_s 16}"
        puts "Size: #{block.len.to_i} bytes"
        puts "Checksum: #{block.checksum.to_i.to_s 16}"
      end
    end
