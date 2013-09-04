require 'spec_helper'

describe Boof::Region do
  describe "parsing a region" do
    before :all do
      @io = File.open File.dirname(__FILE__) + "/etc.bin"
      @region = Boof::Region.read @io
    end

    it "should have a magic constant" do
      expect(@region.magic).to eq "B000FF\n"
    end

    it "should have an image start offset" do
      expect(@region.image_start).to be > 0
    end

    it "should have an image length" do
      expect(@region.image_length).to be > 0
    end
  end
end