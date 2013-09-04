require 'spec_helper'

describe Boof::Block do
  FileName = "etc.bin"

  describe "parsing a block" do
    before :all do
      @io = File.open File.dirname(__FILE__) + "/#{FileName}"
      @region = Boof::Region.read @io
      @first_block = Boof::Block.read @io
    end

    it "should have an address" do
      expect(@first_block.address).to be > 0
    end

    it "should have a size" do
      expect(@first_block.len).to be > 0
    end

    it "should have a checksum" do
      expect(@first_block.checksum).to be > 0
    end

    it "should point to start region" do
      expect(@first_block.address).to eq @region.image_start
    end

    it "should have data with the right length" do
      expect(@first_block.data.size).to be == @first_block.len
    end

    it "should not be the last block" do
      expect(@first_block.last?).to be_false
    end

    it "should have a valid checksum" do
      checksum = @first_block.data.bytes.inject{|sum, x| sum + x }

      expect(checksum).to eq @first_block.checksum
    end
  end

  describe "writing a block" do
    before do
      @block = Boof::Block.new
      @block.len = 6
      @block.data = "abcdef"
      @block.address = 0x10000000
    end

    it "should be in the correct format" do
      @block.checksum = @block.calculate_checksum
      expect(@block.to_binary_s).to eq "\0\0\0\x10\x06\0\0\0U\x02\0\0abcdef".force_encoding('BINARY')
    end

    it "should have a valid checksum" do
      expect(@block.calculate_checksum).to be == 597
    end
  end

  describe "parsing all blocks" do
    before do
      @io = File.open File.dirname(__FILE__) + "/#{FileName}"
      @region = Boof::Region.read @io
    end

    it "should find the last block" do
      loop do
        block = Boof::Block.read @io

        if block.last?
          expect(block.address).to eq 0
          break
        end
      end
    end

    it "should have a valid checksum" do
      loop do
        block = Boof::Block.read @io

        unless block.last?
          expect(block.calculate_checksum).to eq block.checksum
        else
          break
        end
      end
    end
  end
end