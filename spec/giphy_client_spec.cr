# require "http/client"
require "spec"
require "dotenv"
require "webmock"
require "../src/**"

Dotenv.load

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
      g = Giphy::Client.new ENV["API_KEY"]

      expect_raises(ArgumentError) do
        g.search("")
      end
    end

    it "should return 25 gifs by default" do
      api_key = ENV["API_KEY"]
      uri = "https://api.giphy.com/v1/gifs/search?api_key=#{api_key}&limit=25&offset=0&q=cats"
      # TODO: not happy about having to prefix with ./spec
      test_data = File.read("./spec/data/search-default.json")
      WebMock.stub(:get, uri)
        .with(headers: {"Content-Type" => "application/json"})
        .to_return(body: test_data)

      g = Giphy::Client.new api_key

      response = g.search("cats")
      response.meta.status.should eq 200
      response.pagination.count.should eq 25
      response.pagination.offset.should eq 0
    end

    it "should return gifs based on parameters" do
      api_key = ENV["API_KEY"]
      uri = "https://api.giphy.com/v1/gifs/search?api_key=#{api_key}&limit=1&offset=0&q=cats"
      test_data = File.read("./spec/data/search-limited.json")
      WebMock.stub(:get, uri)
        .with(headers: {"Content-Type" => "application/json"})
        .to_return(body: test_data)

      g = Giphy::Client.new api_key
      sp = Giphy::SearchParam.new(limit: 1)

      response = g.search("cats", sp)
      response.meta.status.should eq 200
      response.pagination.count.should eq 1
      response.pagination.offset.should eq 0
    end
  end

  describe "#trending" do
    it "should return 25 gifs by default" do
      api_key = ENV["API_KEY"]
      uri = "https://api.giphy.com/v1/gifs/trending?api_key=#{api_key}&limit=25&offset=0"
      test_data = File.read("./spec/data/trending-default.json")
      WebMock.stub(:get, uri)
        .with(headers: {"Content-Type" => "application/json"})
        .to_return(body: test_data)

      g = Giphy::Client.new api_key

      response = g.trending()
      response.meta.status.should eq 200
      response.pagination.count.should eq 25
      response.pagination.offset.should eq 0
    end

    it "should return gifs based on parameters" do
      api_key = ENV["API_KEY"]
      uri = "https://api.giphy.com/v1/gifs/trending?api_key=#{api_key}&limit=5&offset=500"
      test_data = File.read("./spec/data/trending-limited.json")
      WebMock.stub(:get, uri)
        .with(headers: {"Content-Type" => "application/json"})
        .to_return(body: test_data)

      g = Giphy::Client.new api_key
      tp = Giphy::TrendingParam.new(limit: 5, offset: 500)

      response = g.trending(tp)
      response.meta.status.should eq 200
      response.pagination.count.should eq 5
      response.pagination.offset.should eq 500
    end
  end

  describe "#translate" do
    it "should return a single gif" do
      api_key = ENV["API_KEY"]
      uri = "https://api.giphy.com/v1/gifs/translate?api_key=#{api_key}&weirdness=0&s=baked+beans"
      test_data = File.read("./spec/data/translate-default.json")
      WebMock.stub(:get, uri)
        .with(headers: {"Content-Type" => "application/json"})
        .to_return(body: test_data)

      g = Giphy::Client.new api_key

      response = g.translate("baked beans")
      response.meta.status.should eq 200
    end

    it "should return a gif based on parameters" do
      api_key = ENV["API_KEY"]
      uri = "https://api.giphy.com/v1/gifs/translate?api_key=#{api_key}&weirdness=8&s=baked+beans"
      test_data = File.read("./spec/data/translate-default.json")
      WebMock.stub(:get, uri)
        .with(headers: {"Content-Type" => "application/json"})
        .to_return(body: test_data)

      g = Giphy::Client.new api_key
      tp = Giphy::TranslateParam.new(weirdness: 8)

      response = g.translate("baked beans", tp)
      response.meta.status.should eq 200
    end
  end

  describe "#random" do
    it "should return a single gif" do
      api_key = ENV["API_KEY"]
      uri = "https://api.giphy.com/v1/gifs/random?api_key=#{api_key}"
      test_data = File.read("./spec/data/random-default.json")
      WebMock.stub(:get, uri)
        .with(headers: {"Content-Type" => "application/json"})
        .to_return(body: test_data)

      g = Giphy::Client.new api_key

      response = g.random()
      response.meta.status.should eq 200
    end

    it "should return a gif based on tag" do
      api_key = ENV["API_KEY"]
      uri = "https://api.giphy.com/v1/gifs/random?api_key=#{api_key}&tag=blue+water"
      test_data = File.read("./spec/data/random-default.json")
      WebMock.stub(:get, uri)
        .with(headers: {"Content-Type" => "application/json"})
        .to_return(body: test_data)

      g = Giphy::Client.new api_key

      response = g.random("blue water")
      response.meta.status.should eq 200
    end
  end
end