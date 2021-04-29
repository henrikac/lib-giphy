require "json"

module Giphy
  class Meta
    include JSON::Serializable

    @[JSON::Field(key: "msg")]
    # HTTP Response Message. (required)
    property msg : String

    @[JSON::Field(key: "status")]
    # HTTP Response Code. (required)
    property status : Int32

    @[JSON::Field(key: "response_id")]
    # A unique ID paired with this response from the API.
    property response_id : String?
  end
end