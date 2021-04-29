require "http/client"
require "./params"
require "./types/category"
require "./types/gif"
# require "./types"

# `LibGiphy` is a library that makes it easy to interact with the GIPHY API.
module Giphy
  VERSION = "0.6.0"

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
    def search(q : String, params = SearchParam.new) : GifCollection
      if q.empty?
        raise ArgumentError.new(message = "q is undefined")
      end

      url_path = "/v1/gifs/search"
      param_hash = get_param_hash(params)
      param_hash["q"] = q

      response = send_request(url_path, param_hash)

      if response.status.ok?
        return GifCollection.from_json(response.body)
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
    def trending(params = TrendingParam.new) : GifCollection
      url_path = "/v1/gifs/trending"
      param_hash = get_param_hash(params)

      response = send_request(url_path, param_hash)

      if response.status.ok?
        return GifCollection.from_json(response.body)
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
    def translate(s : String, params = TranslateParam.new) : Gif
      if s.empty?
        raise ArgumentError.new(message = "s is undefined")
      end

      url_path = "/v1/gifs/translate"
      param_hash = get_param_hash(params)
      param_hash["s"] = s

      response = send_request(url_path, param_hash)

      if response.status.ok?
        return Gif.from_json(response.body)
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
    def random(tag = "", params = RandomParam.new) : Gif
      url_path = "/v1/gifs/random"
      param_hash = get_param_hash(params)

      if !tag.empty?
        param_hash["tag"] = tag
      end

      response = send_request(url_path, param_hash)

      if response.status.ok?
        return Gif.from_json(response.body)
      end

      raise Exception.new("#{response.status_code} - #{response.status_message}")
    end

    # Generates a random id that can be used as *random_id* 2when sending a request to GIPHY.
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

    # Returns a gif based on the specified *gif_id*.
    #
    # An `ArgumentError` is raised if *gif_id* is an empty string
    def get_by_id(gif_id : String, random_id : String = "") : Gif
      if gif_id.empty?
        raise ArgumentError.new("gif_id is undefined")
      end

      url_path = "/v1/gifs/#{gif_id}"
      param_hash = {"api_key" => @api_key}

      if !random_id.empty?
        param_hash["random_id"] = random_id
      end

      response = send_request(url_path, param_hash)

      if response.status.ok?
        return Gif.from_json(response.body)
      end

      raise Exception.new("#{response.status_code} - #{response.status_message}")
    end

    # Returns gifs based on the specified *gif_ids*.
    #
    # An `ArgumentError` is raised if *gif_ids* is empty.
    def get_by_ids(gif_ids : Array(String), random_id : String = "") : GifCollection
      if gif_ids.empty?
        raise ArgumentError.new("could not find any gif ids")
      end

      url_path = "/v1/gifs"
      param_hash = {
        "api_key" => @api_key,
        "ids" => gif_ids.join(","),
      }

      if !random_id.empty?
        param_hash["random_id"] = random_id
      end

      response = send_request(url_path, param_hash)

      if response.status.ok?
        return GifCollection.from_json(response.body)
      end

      raise Exception.new("#{response.status_code} - #{response.status_message}")
    end

    # Returns a collection of GIF categories on the GIPHY network.
    def categories : CategoryCollection
      url_path = "/v1/gifs/categories"
      param_hash = {
        "api_key" => @api_key
      }

      response = send_request(url_path, param_hash)

      if response.status.ok?
        return CategoryCollection.from_json(response.body)
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
