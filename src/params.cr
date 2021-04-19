module Lib::Giphy
  private class Param
    @params = Hash(String, String).new

    def to_hash : Hash(String, String)
      @params
    end
  end

  class SearchParam < Param
    def initialize(limit = 25, offset = 0, rating = "", lang = "", random_id = "")
      if limit < 1
        raise ArgumentError.new(message = "limit has to be greater than 0")
      end

      if offset < 0 || offset > 4999
        raise ArgumentError.new(message = "offset has to be between 0 and 4999")
      end

      @params["limit"] = limit.to_s
      @params["offset"] = offset.to_s
      @params["rating"] = rating
      @params["lang"] = lang
      @params["random_id"] = random_id
    end
  end

  class TrendingParam < Param
    def initialize(limit = 25, offset = 0, rating = "", random_id = "")
      if limit < 1
        raise ArgumentError.new(message = "limit has to be greater than 0")
      end

      if offset < 0 || offset > 4999
        raise ArgumentError.new(message = "offset has to be between 0 and 4999")
      end

      @params["limit"] = limit.to_s
      @params["offset"] = offset.to_s
      @params["rating"] = rating
      @params["random_id"] = random_id
    end
  end

  class TranslateParam < Param
    def initialize(weirdness = 0, random_id = "")
      if weirdness < 0 || weirdness > 10
        raise ArgumentError.new(message = "weirdness has to be between 0 and 10")
      end

      @params["weirdness"] = weirdness.to_s
      @params["random_id"] = random_id
    end
  end

  class RandomParam < Param
    def initialize(rating = "", random_id = "")
      @params["rating"] = rating
      @params["random_id"] = random_id
    end
  end
end