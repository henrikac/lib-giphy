# require "http/client"
require "spec"
require "dotenv"
require "webmock"
require "../src/**"

Dotenv.load

API_KEY = ENV["GIPHY_API_KEY"]

describe Giphy::Client do
  describe "#initialize" do
    it "should raise ArgumentError if api_key is an empty string" do
      expect_raises(ArgumentError) do
        Giphy::Client.new("")
      end
    end
  end

  describe "#search" do
    it "should raise ArgumentError if q is an empty string" do
      g = Giphy::Client.new API_KEY

      expect_raises(ArgumentError) do
        g.search("")
      end
    end

    it "should return 25 gifs by default" do
      uri = "https://api.giphy.com/v1/gifs/search?api_key=#{API_KEY}&limit=25&offset=0&q=cats"
      # TODO: not happy about having to prefix with ./spec
      test_data = File.read("./spec/data/search-default.json")
      WebMock.stub(:get, uri)
        .with(headers: {"Content-Type" => "application/json"})
        .to_return(body: test_data)

      g = Giphy::Client.new API_KEY

      response = g.search("cats")
      response.meta.status.should eq 200
      response.pagination.count.should eq 25
      response.pagination.offset.should eq 0
    end

    it "should return gifs based on parameters" do
      uri = "https://api.giphy.com/v1/gifs/search?api_key=#{API_KEY}&limit=1&offset=0&q=cats"
      test_data = File.read("./spec/data/search-limited.json")
      WebMock.stub(:get, uri)
        .with(headers: {"Content-Type" => "application/json"})
        .to_return(body: test_data)

      g = Giphy::Client.new API_KEY
      sp = Giphy::SearchParam.new(limit: 1)

      response = g.search("cats", sp)
      response.meta.status.should eq 200
      response.pagination.count.should eq 1
      response.pagination.offset.should eq 0
    end
  end

  describe "#trending" do
    it "should return 25 gifs by default" do
      uri = "https://api.giphy.com/v1/gifs/trending?api_key=#{API_KEY}&limit=25&offset=0"
      test_data = File.read("./spec/data/trending-default.json")
      WebMock.stub(:get, uri)
        .with(headers: {"Content-Type" => "application/json"})
        .to_return(body: test_data)

      g = Giphy::Client.new API_KEY

      response = g.trending()
      response.meta.status.should eq 200
      response.pagination.count.should eq 25
      response.pagination.offset.should eq 0
    end

    it "should return gifs based on parameters" do
      uri = "https://api.giphy.com/v1/gifs/trending?api_key=#{API_KEY}&limit=5&offset=500"
      test_data = File.read("./spec/data/trending-limited.json")
      WebMock.stub(:get, uri)
        .with(headers: {"Content-Type" => "application/json"})
        .to_return(body: test_data)

      g = Giphy::Client.new API_KEY
      tp = Giphy::TrendingParam.new(limit: 5, offset: 500)

      response = g.trending(tp)
      response.meta.status.should eq 200
      response.pagination.count.should eq 5
      response.pagination.offset.should eq 500
    end
  end

  describe "#translate" do
    it "should return a single gif" do
      uri = "https://api.giphy.com/v1/gifs/translate?api_key=#{API_KEY}&weirdness=0&s=baked+beans"
      test_data = File.read("./spec/data/translate-default.json")
      WebMock.stub(:get, uri)
        .with(headers: {"Content-Type" => "application/json"})
        .to_return(body: test_data)

      g = Giphy::Client.new API_KEY

      response = g.translate("baked beans")
      response.meta.status.should eq 200
    end

    it "should return a gif based on parameters" do
      uri = "https://api.giphy.com/v1/gifs/translate?api_key=#{API_KEY}&weirdness=8&s=baked+beans"
      test_data = File.read("./spec/data/translate-default.json")
      WebMock.stub(:get, uri)
        .with(headers: {"Content-Type" => "application/json"})
        .to_return(body: test_data)

      g = Giphy::Client.new API_KEY
      tp = Giphy::TranslateParam.new(weirdness: 8)

      response = g.translate("baked beans", tp)
      response.meta.status.should eq 200
    end
  end

  describe "#random" do
    it "should return a single gif" do
      uri = "https://api.giphy.com/v1/gifs/random?api_key=#{API_KEY}"
      test_data = File.read("./spec/data/random-default.json")
      WebMock.stub(:get, uri)
        .with(headers: {"Content-Type" => "application/json"})
        .to_return(body: test_data)

      g = Giphy::Client.new API_KEY

      response = g.random()
      response.meta.status.should eq 200
    end

    it "should return a gif based on tag" do
      uri = "https://api.giphy.com/v1/gifs/random?api_key=#{API_KEY}&tag=blue+water"
      test_data = File.read("./spec/data/random-default.json")
      WebMock.stub(:get, uri)
        .with(headers: {"Content-Type" => "application/json"})
        .to_return(body: test_data)

      g = Giphy::Client.new API_KEY

      response = g.random("blue water")
      response.meta.status.should eq 200
    end
  end

  describe "#generate_random_id" do
    it "should return a non-empty string" do
      uri = "https://api.giphy.com/v1/randomid?api_key=#{API_KEY}"
      test_data = "{\"data\": {\"random_id\": \"#{Random::Secure.hex}\"}}"
      WebMock.stub(:get, uri)
        .to_return(body: test_data)
      
      g = Giphy::Client.new API_KEY

      result = g.generate_random_id
      result.should_not be_empty
    end

    it "should return a random string" do
      uri = "https://api.giphy.com/v1/randomid?api_key=#{API_KEY}"

      # Setup for random id #1
      test_data = "{\"data\": {\"random_id\": \"#{Random::Secure.hex}\"}}"
      WebMock.stub(:get, uri)
        .to_return(body: test_data)
      
      g = Giphy::Client.new API_KEY

      str1 = g.generate_random_id

      # TODO: Figure out how to do this better
      WebMock.reset
      # Setup for random id #2
      test_data = "{\"data\": {\"random_id\": \"#{Random::Secure.hex}\"}}"
      WebMock.stub(:get, uri)
        .to_return(body: test_data)

      str2 = g.generate_random_id

      # Asserting
      str1.should_not eq str2
    end
  end

  describe "#get_by_id" do
    it "should return a gif" do
      gif_id = "102jf1094fn18394fn"
      uri = "https://api.giphy.com/v1/gifs/#{gif_id}?api_key=#{API_KEY}"
      test_data = File.read("./spec/data/get-by-id.json")
      WebMock.stub(:get, uri)
        .with(headers: {"Content-Type" => "application/json"})
        .to_return(body: test_data)
      
      g = Giphy::Client.new API_KEY

      response = g.get_by_id(gif_id)
      response.meta.status.should eq 200
    end

    it "should raise an ArgumentError if gif_id is an empty string" do
      expect_raises(ArgumentError) do
        Giphy::Client.new(API_KEY).get_by_id("")
      end
    end
  end

  describe "#get_by_ids" do
    it "should return one or more gifs" do
      ids = ["8914jf1384j", "04mf04f0qw4f"]
      uri = "https://api.giphy.com/v1/gifs?api_key=#{API_KEY}&ids=#{ids[0]},#{ids[1]}"
      test_data = File.read("./spec/data/get-by-ids.json")
      WebMock.stub(:get, uri)
        .with(headers: {"Content-Type" => "application/json"})
        .to_return(body: test_data)
      
      g = Giphy::Client.new API_KEY

      response = g.get_by_ids(ids)
      response.meta.status.should eq 200
    end

    it "should raise an ArgumentError if gif_ids is empty" do
      expect_raises(ArgumentError) do
        ids = Array(String).new
        Giphy::Client.new(API_KEY).get_by_ids(ids)
      end
    end
  end

  describe "#categories" do
    it "should return a collection of categories" do
      uri = "https://api.giphy.com/v1/gifs/categories?api_key=#{API_KEY}"
      test_data = File.read("./spec/data/get-categories.json")
      WebMock.stub(:get, uri)
        .with(headers: {"Content-Type" => "application/json"})
        .to_return(body: test_data)
      
      g = Giphy::Client.new API_KEY

      response = g.categories
      response.meta.status.should eq 200
    end
  end
end