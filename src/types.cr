require "json"

module Lib::Giphy
  class GifData
    include JSON::Serializable

    @[JSON::Field(key: "data")]
    property data : Array(Gif)

    @[JSON::Field(key: "pagination")]
    property pagination : Pagination

    @[JSON::Field(key: "meta")]
    property meta : Meta
  end

  class GifTranslate
    include JSON::Serializable

    @[JSON::Field(key: "data")]
    property data : Gif

    @[JSON::Field(key: "meta")]
    property meta : Meta
  end

  class Gif
    include JSON::Serializable

    # By default, this is almost always GIF
    @[JSON::Field(key: "type")]
    property type : String?

    # This GIF's unique ID
    @[JSON::Field(key: "id")]
    property id : String?

    # The unique slug used in this GIF's URL
    @[JSON::Field(key: "slug")]
    property slug : String?

    # The unique URL for this GIF
    @[JSON::Field(key: "url")]
    property url : String?

    # The unique bit.ly URL for this GIF
    @[JSON::Field(key: "bitly_url")]
    property bitly_url : String?

    # A URL used for embedding this GIF
    @[JSON::Field(key: "embed_url")]
    property embed_url : String?

    # The username this GIF is attached to, if applicable
    @[JSON::Field(key: "username")]
    property username : String?

    # The page on which this GIF was found
    @[JSON::Field(key: "source")]
    property source : String?

    # The MPAA-style rating for this content.
    # Examples include Y, G, PG, PG-13 and R
    @[JSON::Field(key: "rating")]
    property rating : String?

    # Currently unused
    @[JSON::Field(key: "content_url")]
    property content_url : String?

    # An object containing data about the user associated with this GIF, if applicable.
    @[JSON::Field(key: "user")]
    property user : User?

    # The top level domain of the source URL.
    @[JSON::Field(key: "source_tld")]
    property source_tld : String?

    # The URL of the webpage on which this GIF was found.
    @[JSON::Field(key: "source_post_url")]
    property source_post_url : String?
    
    # The date on which this GIF was last updated.
    @[JSON::Field(key: "update_datetime")]
    property update_datetime : String?

    # The date this GIF was added to the GIPHY database.
    @[JSON::Field(key: "create_datetime")]
    property create_datetime : String?

    # The creation or upload date from this GIF's source.
    @[JSON::Field(key: "import_datetime")]
    property import_datetime : String?

    # The date on which this gif was marked trending, if applicable.
    @[JSON::Field(key: "trending_datetime")]
    property trending_datetime : String?

    # An object containing data for various available formats and sizes of this GIF.
    @[JSON::Field(key: "images")]
    property images : Images

    # The title that appears on giphy.com for this GIF.
    @[JSON::Field(key: "title")]
    property title : String?
  end

  class User
    include JSON::Serializable

    # The URL for this user's avatar image.
    @[JSON::Field(key: "avatar_url")]
    property avatar_url : String?

    # The URL for the banner image that appears atop this user's profile page.
    @[JSON::Field(key: "banner_url")]
    property banner_url : String?

    # The URL for this user's GIPHY profile.
    @[JSON::Field(key: "profile_url")]
    property profile_url : String?

    # The username associated with this user.
    @[JSON::Field(key: "username")]
    property username : String?

    # The display name associated with this user
    # (contains formatting the base username might not).
    @[JSON::Field(key: "display_name")]
    property display_name : String?
  end

  class Meta
    include JSON::Serializable

    # HTTP Response Message. (required)
    @[JSON::Field(key: "msg")]
    property msg : String

    # HTTP Response Code. (required)
    @[JSON::Field(key: "status")]
    property status : Int32

    # A unique ID paired with this response from the API.
    @[JSON::Field(key: "response_id")]
    property response_id : String?
  end

  class Pagination
    include JSON::Serializable

    # Position in pagination.
    @[JSON::Field(key: "offset")]
    property offset : Int32

    # Total number of items available (not returned on every endpoint).
    @[JSON::Field(key: "total_count")]
    property total_count : Int32

    # Total number of items returned.
    @[JSON::Field(key: "count")]
    property count : Int32
  end

  class Images
    include JSON::Serializable

    # Data on versions of this GIF with a fixed height of 200 pixels. Good for mobile use.
    @[JSON::Field(key: "fixed_height")]
    property fixed_height : ExtendedImageDataVideo

    # Data on a static image of this GIF with a fixed height of 200 pixels.
    @[JSON::Field(key: "fixed_height_still")]
    property fixed_height_still : ImageData

    # Data on versions of this GIF with a fixed height of 200 pixels and the number of frames reduced to 6.
    @[JSON::Field(key: "fixed_height_downsampled")]
    property fixed_height_downsampled : ExtendedImageData

    # Data on versions of this GIF with a fixed width of 200 pixels. Good for mobile use.
    @[JSON::Field(key: "fixed_width")]
    property fixed_width : ExtendedImageDataVideo

    # Data on a static image of this GIF with a fixed width of 200 pixels.
    @[JSON::Field(key: "fixed_width_still")]
    property fixed_width_still : ImageData

    # Data on versions of this GIF with a fixed width of 200 pixels and the number of frames reduced to 6.
    @[JSON::Field(key: "fixed_width_downsampled")]
    property fixed_width_downsampled : ExtendedImageData

    # Data on versions of this GIF with a fixed height of 100 pixels. Good for mobile keyboards.
    @[JSON::Field(key: "fixed_height_small")]

    # Data on a static image of this GIF with a fixed height of 100 pixels.
    @[JSON::Field(key: "fixed_height_small_still")]
    property fixed_height_small_still : ImageData

    # Data on versions of this GIF with a fixed width of 100 pixels. Good for mobile keyboards.
    @[JSON::Field(key: "fixed_width_small")]
    property fixed_width_small : ExtendedImageDataVideo

    # Data on a static image of this GIF with a fixed width of 100 pixels.
    @[JSON::Field(key: "fixed_width_small_still")]
    property fixed_width_small_still : ImageData

    # Data on a version of this GIF downsized to be under 2mb.
    @[JSON::Field(key: "downsized")]
    property downsized : SizedImageData

    # Data on a static preview image of the downsized version of this GIF.
    @[JSON::Field(key: "downsized_still")]
    property downsized_still : ImageData

    # Data on a version of this GIF downsized to be under 8mb.
    @[JSON::Field(key: "downsized_large")]
    property downsized_large : SizedImageData

    # Data on a version of this GIF downsized to be under 5mb.
    @[JSON::Field(key: "downsized_medium")]
    property downsized_medium : SizedImageData

    # Data on a version of this GIF downsized to be under 200kb.
    @[JSON::Field(key: "downsized_small")]
    property downsized_small : VideoData

    # Data on the original version of this GIF. Good for desktop use.
    @[JSON::Field(key: "original")]
    property original : ExtendedImageDataFrame

    # Data on a static preview image of the original GIF.
    @[JSON::Field(key: "original_still")]
    property original_still : ImageData

    # Data on the 15 second version of the GIF looping.
    @[JSON::Field(key: "looping")]
    property looping : LooperData

    # Data on a version of this GIF in .MP4 format limited to 50kb that displays the first 1-2 seconds of the GIF.
    @[JSON::Field(key: "preview")]
    property preview : VideoData

    # Data on a version of this GIF limited to 50kb that displays the first 1-2 seconds of the GIF.
    @[JSON::Field(key: "preview_gif")]
    property preview_gif : ImageData

    class ImageData
      include JSON::Serializable

      # The publicly-accessible direct URL for this GIF.
      @[JSON::Field(key: "url")]
      property url : String?

      # The width of this GIF in pixels.
      @[JSON::Field(key: "width")]
      property width : String?

      # The height of this GIF in pixels.
      @[JSON::Field(key: "height")]
      property height : String?
    end

    class SizedImageData < ImageData
      include JSON::Serializable

      # The size of this GIF in bytes.
      @[JSON::Field(key: "size")]
      property size : String?
    end

    class ExtendedImageData < SizedImageData
      include JSON::Serializable

      # The URL for this GIF in .webp format.
      @[JSON::Field(key: "webp")]
      property webp : String?

      # The size in bytes of the .webp file corresponding to this GIF.
      @[JSON::Field(key: "webp_size")]
      property webp_size : String?
    end

    class ExtendedImageDataVideo < ExtendedImageData
      include JSON::Serializable

      # The URL for this GIF in .MP4 format.
      @[JSON::Field(key: "mp4")]
      property mp4 : String?

      # The size in bytes of the .MP4 file corresponding to this GIF.
      @[JSON::Field(key: "mp4_size")]
      property mp4_size : String?
    end

    class ExtendedImageDataFrame
      include JSON::Serializable

      # The width of this GIF in pixels.
      @[JSON::Field(key: "width")]
      property width : String?

      # The height of this GIF in pixels.
      @[JSON::Field(key: "height")]
      property height : String?

      # The size of this GIF in bytes.
      @[JSON::Field(key: "size")]
      property size : String?

      # The number of frames in this GIF.
      @[JSON::Field(key: "frames")]
      property frames : String?

      # The URL for this GIF in .MP4 format.
      @[JSON::Field(key: "mp4")]
      property mp4 : String?

      # The size in bytes of the .MP4 file corresponding to this GIF.
      @[JSON::Field(key: "mp4_size")]
      property mp4_size : String?

      # The URL for this GIF in .webp format.
      @[JSON::Field(key: "webp")]
      property webp : String?

      # The size in bytes of the .webp file corresponding to this GIF.
      @[JSON::Field(key: "webp_size")]
      property webp_size : String?
    end

    class VideoData
      include JSON::Serializable

      # The publicly-accessible direct URL for this GIF.
      @[JSON::Field(key: "mp4")]
      property mp4 : String?

      # The width of this GIF in pixels.
      @[JSON::Field(key: "width")]
      property width : String?

      # The height of this GIF in pixels.
      @[JSON::Field(key: "height")]
      property height : String?

      # The size of this GIF in bytes.
      @[JSON::Field(key: "mp4_size")]
      property mp4_size : String?
    end

    class LooperData
      include JSON::Serializable

      # The URL for this GIF in .MP4 format.
      @[JSON::Field(key: "mp4")]
      property mp4 : String?
    end
  end
end