require "http/client"
require "json"

# TODO: Write documentation for `Lib::Giphy`
module Lib::Giphy
  VERSION = "0.1.0"

  class Giphy
    HOST = "api.giphy.com"
    HEADERS = HTTP::Headers{
      "Content-Type" => "application/json",
    }

    def initialize(api_key : String)
      if api_key.empty?
        raise ArgumentError.new(message = "api_key is undefined")
      end

      @api_key = api_key
    end

    # Returns gifs from GIPHY based on search term
    #
    # Example: (default search)
    # ```
    # g = Lib::Giphy::Giphy.new <api_key>
    # gifs = g.search("cats") # returns 25 gifs by default
    #
    # gifs.data.each do |gif|
    #   puts gif.title
    # end
    # ```
    #
    # Example: (search with params)
    # ```
    # g = Lib::Giphy::Giphy.new <api_key>
    # params = Lib::Giphy::SearchParam.new 10
    # gifs = g.search("cats", params) # returns 10 gifs
    # ```
    def search(q : String, params = SearchParam.new) : GifData
      if q.empty?
        raise ArgumentError.new(message = "q is undefined")
      end

      url_path = "v1/gifs/search"
      param_hash = Hash(String, String).new
      param_hash["api_key"] = @api_key
      param_hash["q"] = q

      params.to_hash.each do |key, value|
        if !value.empty?
          param_hash[key] = value
        end
      end

      query_string = URI::Params.encode(param_hash)

      response = HTTP::Client.get(
        URI.new("http", HOST, nil, url_path, query: query_string),
        HEADERS,
      )

      if !response.success?
        # TODO: Check if okay? or if there is a better way
        # to return an empty GifData, or maybe return nil instead?
        return GifData.new JSON::PullParser.new "{}"
      end

      gif_data = GifData.from_json(response.body)

      return gif_data
    end

    def trending
      raise NotImplementedError.new("trending")
    end

    def translate
      raise NotImplementedError.new("translate")
    end

    def random
      raise NotImplementedError.new("random")
    end
  end
end
