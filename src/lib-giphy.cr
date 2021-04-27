require "http/client"
require "./params"
require "./types"

# `LibGiphy` is a library that makes it easy to interact with the GIPHY API.
module Giphy
  VERSION = "0.5.0"

  # Giphy::Client is the object that communicates with the GIPHY API.
  #
  # To create a Giphy::Client
  # ```
  # giphy = Giphy::Client.new <api_key>
  # ```
  #
  # NOTE: An *api_key* is required for Giphy::Client to communite with the GIHPY API.
  class Client
    HOST = "api.giphy.com"
    HEADERS = HTTP::Headers{
      "Content-Type" => "application/json",
    }

    # Creates a new Giphy with the specified *api_key*
    def initialize(api_key : String)
      if api_key.empty?
        raise ArgumentError.new(message = "api_key is undefined")
      end

      @api_key = api_key
    end

    # Returns gifs from GIPHY based on search term *q*
    #
    # Example: (default search)
    # ```
    # g = Giphy::Client.new <api_key>
    # gifs = g.search("cats") # returns 25 gifs by default
    #
    # gifs.data.each do |gif|
    #   puts gif.title
    # end
    # ```
    #
    # Example: (search with params)
    # ```
    # g = Giphy::Client.new <api_key>
    # params = Giphy::SearchParam.new 10
    # gifs = g.search("cats", params) # returns 10 gifs
    # ```
    def search(q : String, params = SearchParam.new) : GifData
      if q.empty?
        raise ArgumentError.new(message = "q is undefined")
      end

      url_path = "/v1/gifs/search"
      param_hash = get_param_hash(params)
      param_hash["q"] = q

      response = send_request(url_path, param_hash)

      if response.status.ok?
        return GifData.from_json(response.body)
      end

      raise Exception.new("#{response.status_code} - #{response.status_message}")
    end

    # Returns the most relevant and engaging gifs
    #
    # Example: (default search)
    # ```
    # g = Giphy::Client.new <api_key>
    # gifs = g.trending() # returns 25 gifs by default
    #
    # gifs.data.each do |gif|
    #   puts gif.title
    # end
    # ```
    def trending(params = TrendingParam.new) : GifData
      url_path = "/v1/gifs/trending"
      param_hash = get_param_hash(params)

      response = send_request(url_path, param_hash)

      if response.status.ok?
        return GifData.from_json(response.body)
      end

      raise Exception.new("#{response.status_code} - #{response.status_message}")
    end

    # Returns a single gif based on the search term *s*.
    # Translate converts words and phrases to gifs using 
    # GIPHY's special sauce algorithm.
    #
    # Example: (default search)
    # ```
    # g = Giphy::Client.new <api_key>
    # gif = g.translate("oh weeew")
    #
    # puts gif.data.title
    # ```
    def translate(s : String, params = TranslateParam.new) : GifDataSingle
      if s.empty?
        raise ArgumentError.new(message = "s is undefined")
      end

      url_path = "/v1/gifs/translate"
      param_hash = get_param_hash(params)
      param_hash["s"] = s

      response = send_request(url_path, param_hash)

      if response.status.ok?
        return GifDataSingle.from_json(response.body)
      end

      raise Exception.new("#{response.status_code} - #{response.status_message}")
    end

    # Returns a random gif based on the specified *tag*.
    # If tag == "" the gif will be completely random.
    #
    # Example: (default search)
    # ```
    # g = Giphy::Client.new <api_key>
    # gif = g.random("oh weeew")
    #
    # puts gif.data.url
    # ```
    def random(tag = "", params = RandomParam.new) : GifDataSingle
      url_path = "/v1/gifs/random"
      param_hash = get_param_hash(params)

      if !tag.empty?
        param_hash["tag"] = tag
      end

      response = send_request(url_path, param_hash)

      if response.status.ok?
        return GifDataSingle.from_json(response.body)
      end

      raise Exception.new("#{response.status_code} - #{response.status_message}")
    end

    # Generates a random id that can be used as *random_id* in 
    # `Giphy::SearchParam`, `Giphy::TrendingParam`, `Giphy::TranslateParan` 
    # and `Giphy::RandomParam`.
    #
    # NOTE: for more information see https://developers.giphy.com/docs/api/endpoint#random-id
    def generate_random_id : String
      url_path = "/v1/randomid"
      param_hash = {"api_key" => @api_key}

      response = send_request(url_path, param_hash)

      if response.status.ok?
        return JSON.parse(response.body)["data"]["random_id"].to_s
      end

      raise Exception.new("#{response.status_code} - #{response.status_message}")
    end

    # Returns a Hash with parameters that is required to send
    # a request to the GIPHY API.
    private def get_param_hash(params : Param) : Hash(String, String)
      hash = Hash(String, String).new
      hash["api_key"] = @api_key

      params.to_hash.each do |key, value|
        if !value.empty?
          hash[key] = value
        end
      end

      return hash
    end

    # Returns the response received from GIPHY.
    private def send_request(path : String, params : Hash(String, String)) : HTTP::Client::Response
      query_string = URI::Params.encode(params)
      return HTTP::Client.get(
        URI.new("https", HOST, nil, path, query: query_string),
        HEADERS,
      )
    end
  end
end
