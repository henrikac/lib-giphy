require "json"

module Giphy
  class Pagination
    include JSON::Serializable

    @[JSON::Field(key: "offset")]
    # Position in pagination.
    property offset : Int32?

    @[JSON::Field(key: "total_count")]
    # Total number of items available (not returned on every endpoint).
    property total_count : Int32

    @[JSON::Field(key: "count")]
    # Total number of items returned.
    property count : Int32
  end
end