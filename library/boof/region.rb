# encoding: utf-8

module Boof
  class Region < BinData::Record
    endian :little

    string :magic, read_length: 7
    uint32 :image_start
    uint32 :image_length
  end
end