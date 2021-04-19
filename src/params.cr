module Lib::Giphy
  # Param represents param types that can be used is various `Giphy` methods.
  class Param
    @params = Hash(String, String).new

    # Returns the *params*
    def to_hash : Hash(String, String)
      @params
    end
  end

  # SearchParam contains additional parameters that can be used when
  # calling `Giphy.search`.
  class SearchParam < Param
    # Creates a new `SearchParam` with the specified *limit*, *offset*, *rating*,
    # *lang* and *random_id*.
    #
    # An `ArgumentError` is raised if:
    # + *limit* is < 1
    # + *offset* is < 0 or >= 5000
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

  # TrendingParam contains additional parameters that can be used when
  # calling `Giphy.trending`.
  class TrendingParam < Param
    # Creates a new `TrendingParam` with the specified *limit*, *offset*, *rating*
    # and *random_id*.
    #
    # An `ArgumentError` is raised if:
    # + *limit* is < 1
    # + *offset* is < 0 or >= 5000
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

  # TranslateParam contains additional parameters that can be used when
  # calling `Giphy.translate`.
  class TranslateParam < Param
    # Creates a new `TranslateParam` with the specified *weirdness* and *random_id*.
    #
    # An `ArgumentError` is raised if:
    # + *weirdness* is < 0 or > 10
    def initialize(weirdness = 0, random_id = "")
      if weirdness < 0 || weirdness > 10
        raise ArgumentError.new(message = "weirdness has to be between 0 and 10")
      end

      @params["weirdness"] = weirdness.to_s
      @params["random_id"] = random_id
    end
  end

  # RandomParam contains additional parameters that can be used when
  # calling `Giphy.random`.
  class RandomParam < Param
    # Creates a new `RandomParam` with the specified *rating* and *random_id*.
    def initialize(rating = "", random_id = "")
      @params["rating"] = rating
      @params["random_id"] = random_id
    end
  end
end