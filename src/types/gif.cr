require "json"
require "./images"
require "./meta"
require "./pagination"
require "./user"

module Giphy
  class GifCollection
    include JSON::Serializable

    @[JSON::Field(key: "data")]
    property data : Array(GifData)

    @[JSON::Field(key: "pagination")]
    property pagination : Pagination

    @[JSON::Field(key: "meta")]
    property meta : Meta
  end

  class Gif
    include JSON::Serializable

    @[JSON::Field(key: "data")]
    property data : GifData

    @[JSON::Field(key: "meta")]
    property meta : Meta
  end

  class GifData
    include JSON::Serializable

    @[JSON::Field(key: "type")]
    # By default, this is almost always GIF
    property type : String?

    @[JSON::Field(key: "id")]
    # This GIF's unique ID
    property id : String?

    @[JSON::Field(key: "slug")]
    # The unique slug used in this GIF's URL
    property slug : String?

    @[JSON::Field(key: "url")]
    # The unique URL for this GIF
    property url : String?

    @[JSON::Field(key: "bitly_url")]
    # The unique bit.ly URL for this GIF
    property bitly_url : String?

    @[JSON::Field(key: "embed_url")]
    # A URL used for embedding this GIF
    property embed_url : String?

    @[JSON::Field(key: "username")]
    # The username this GIF is attached to, if applicable
    property username : String?

    @[JSON::Field(key: "source")]
    # The page on which this GIF was found
    property source : String?

    @[JSON::Field(key: "rating")]
    # The MPAA-style rating for this content.
    # Examples include Y, G, PG, PG-13 and R
    property rating : String?

    @[JSON::Field(key: "content_url")]
    # Currently unused
    property content_url : String?

    @[JSON::Field(key: "user")]
    # An object containing data about the user associated with this GIF, if applicable.
    property user : User?

    @[JSON::Field(key: "source_tld")]
    # The top level domain of the source URL.
    property source_tld : String?

    @[JSON::Field(key: "source_post_url")]
    # The URL of the webpage on which this GIF was found.
    property source_post_url : String?
    
    @[JSON::Field(key: "update_datetime")]
    # The date on which this GIF was last updated.
    property update_datetime : String?

    @[JSON::Field(key: "create_datetime")]
    # The date this GIF was added to the GIPHY database.
    property create_datetime : String?

    @[JSON::Field(key: "import_datetime")]
    # The creation or upload date from this GIF's source.
    property import_datetime : String?

    @[JSON::Field(key: "trending_datetime")]
    # The date on which this gif was marked trending, if applicable.
    property trending_datetime : String?

    @[JSON::Field(key: "images")]
    # An object containing data for various available formats and sizes of this GIF.
    property images : Images?

    @[JSON::Field(key: "title")]
    # The title that appears on giphy.com for this GIF.
    property title : String?
  end

end