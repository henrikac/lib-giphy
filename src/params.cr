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

  class TrendingParam
    @hash = Hash(String, String).new

    def initialize(limit = 25, offset = 0, rating = "", random_id = "")
      if limit < 1
        raise ArgumentError.new(message = "limit has to be greater than 0")
      end

      if offset < 0 || offset > 4999
        raise ArgumentError.new(message = "offset has to be between 0 and 4999")
      end

      @hash["limit"] = limit.to_s
      @hash["offset"] = offset.to_s
      @hash["rating"] = rating
      @hash["random_id"] = random_id
    end

    def to_hash : Hash(String, String)
      @hash
    end
  end

  class TranslateParam
    @hash = Hash(String, String).new

    def initialize(weirdness = 0, random_id = "")
      if weirdness < 0 || weirdness > 10
        raise ArgumentError.new(message = "weirdness has to be between 0 and 10")
      end

      @hash["weirdness"] = weirdness.to_s
      @hash["random_id"] = random_id
    end

    def to_hash : Hash(String, String)
      @hash
    end
  end

  class RandomParam
    @hash = Hash(String, String).new

    def initialize(rating = "", random_id = "")
      @hash["rating"] = rating
      @hash["random_id"] = random_id
    end

    def to_hash : Hash(String, String)
      @hash
    end
  end
end