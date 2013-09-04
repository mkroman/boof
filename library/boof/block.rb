# encoding: utf-8

module Boof
  class Block < BinData::Record
    endian :little

    uint32 :address
    uint32 :len
    uint32 :checksum
    string :data, :read_length => lambda { len }

    def last?
      self.address + self.len + self.checksum == 0
    end

    def calculate_checksum
      data.bytes.inject{|sum, x| sum + x }
    end
  end
end