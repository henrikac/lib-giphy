require "spec"
require "../src/params"

describe Giphy::SearchParam do
  describe "#initialize" do
    it "should initialize a new Giphy::SearchParam object" do
      Giphy::SearchParam.new.should_not be_nil
    end

    it "should inherit from Giphy::Param" do
      sp = Giphy::SearchParam.new
      sp.is_a?(Giphy::Param).should eq true
    end

    it "default Giphy::SearchParam should have default values set correctly" do
      sp = Giphy::SearchParam.new

      params = sp.to_hash
      params["limit"].should eq "25"
      params["offset"].should eq "0"
      params["rating"].should eq ""
      params["lang"].should eq ""
      params["random_id"].should eq ""
    end

    it "limit lower than 1 should raise ArgumentError" do
      expect_raises(ArgumentError) do
        Giphy::SearchParam.new(0)
      end
    end

    it "offset lower than 0 should raise ArgumentError" do
      expect_raises(ArgumentError) do
        Giphy::SearchParam.new(offset: -1)
      end
    end

    it "offset greater than or equal to 5000 should raise ArgumentError" do
      expect_raises(ArgumentError) do
        Giphy::SearchParam.new(offset: 5000)
      end
    end
  end
end

describe Giphy::TrendingParam do
  describe "#initialize" do
    it "should initialize a new Giphy::TrendingParam object" do
      Giphy::TrendingParam.new.should_not be_nil
    end

    it "should inherit from Giphy::Param" do
      tp = Giphy::TrendingParam.new
      tp.is_a?(Giphy::Param).should eq true
    end

    it "default Giphy::TrendingParam should have default values set correctly" do
      tp = Giphy::TrendingParam.new

      params = tp.to_hash
      params["limit"].should eq "25"
      params["offset"].should eq "0"
      params["rating"].should eq ""
      params["random_id"].should eq ""
    end

    it "limit lower than 1 should raise ArgumentError" do
      expect_raises(ArgumentError) do
        Giphy::TrendingParam.new(0)
      end
    end

    it "offset lower than 0 should raise ArgumentError" do
      expect_raises(ArgumentError) do
        Giphy::TrendingParam.new(offset: -1)
      end
    end

    it "offset greater than or equal to 5000 should raise ArgumentError" do
      expect_raises(ArgumentError) do
        Giphy::TrendingParam.new(offset: 5000)
      end
    end
  end
end

describe Giphy::TranslateParam do
  describe "#initialize" do
    it "should initialize a new Giphy::TranslateParam object" do
      Giphy::TranslateParam.new.should_not be_nil
    end

    it "should inherit from Giphy::Param" do
      tp = Giphy::TranslateParam.new
      tp.is_a?(Giphy::Param).should eq true
    end

    it "default Giphy::TranslateParam should have default values set correctly" do
      tp = Giphy::TranslateParam.new

      params = tp.to_hash
      params["weirdness"].should eq "0"
      params["random_id"].should eq ""
    end

    it "weirdness lower than 0 should raise an ArgumentError" do
      expect_raises(ArgumentError) do
        Giphy::TranslateParam.new(weirdness: -1)
      end
    end

    it "weirdness greater than 10 should raise an ArgumentError" do
      expect_raises(ArgumentError) do
        Giphy::TranslateParam.new(weirdness: 11)
      end
    end
  end
end

describe Giphy::RandomParam do
  describe "#initialize" do
    it "should initialize a new Giphy::RandomParam object" do
      Giphy::RandomParam.new.should_not be_nil
    end

    it "should inherit from Giphy::Param" do
      rp = Giphy::RandomParam.new
      rp.is_a?(Giphy::Param).should eq true
    end

    it "default Giphy::RandomParam should have default values set correctly" do
      rp = Giphy::RandomParam.new

      params = rp.to_hash
      params["rating"].should eq ""
      params["random_id"].should eq ""
    end
  end
end