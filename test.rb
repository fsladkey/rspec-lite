require_relative './rspec_lite.rb'

describe "math" do

  describe "plus" do

    it "works" do
      expect(1 + 1).to eq 2
    end

    it "does not work" do
      expect(2 + 2).not_to eq 4
    end

  end

  describe "minus" do
    it "works" do
      expect(5 - 1).to eq 4
    end

    it "does not work" do
      expect(1 - 1).not_to eq 0
    end
  end

end
