module Lib::Giphy
  class SearchParam
    @hash = Hash(String, String).new

    def initialize(limit = 25, offset = 0, rating = "", lang = "", random_id = "")
      if limit < 1
        raise ArgumentError.new(message = "limit has to be greater than 0")
      end

      if offset < 0 || offset > 4999
        raise ArgumentError.new(message = "offset has to be between 0 and 4999")
      end

      @hash["limit"] = limit.to_s
      @hash["offset"] = offset.to_s
      @hash["rating"] = rating
      @hash["lang"] = lang
      @hash["random_id"] = random_id
    end

    def to_hash : Hash(String, String)
      @hash
    end
  end
end