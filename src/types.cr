require "json"

module Giphy
  class GifData
    include JSON::Serializable

    @[JSON::Field(key: "data")]
    property data : Array(Gif)

    @[JSON::Field(key: "pagination")]
    property pagination : Pagination

    @[JSON::Field(key: "meta")]
    property meta : Meta
  end

  class GifDataSingle
    include JSON::Serializable

    @[JSON::Field(key: "data")]
    property data : Gif

    @[JSON::Field(key: "meta")]
    property meta : Meta
  end

  class Gif
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

  class User
    include JSON::Serializable

    @[JSON::Field(key: "avatar_url")]
    # The URL for this user's avatar image.
    property avatar_url : String?

    @[JSON::Field(key: "banner_url")]
    # The URL for the banner image that appears atop this user's profile page.
    property banner_url : String?

    @[JSON::Field(key: "profile_url")]
    # The URL for this user's GIPHY profile.
    property profile_url : String?

    @[JSON::Field(key: "username")]
    # The username associated with this user.
    property username : String?

    @[JSON::Field(key: "display_name")]
    # The display name associated with this user
    # (contains formatting the base username might not).
    property display_name : String?
  end

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

  class Pagination
    include JSON::Serializable

    @[JSON::Field(key: "offset")]
    # Position in pagination.
    property offset : Int32

    @[JSON::Field(key: "total_count")]
    # Total number of items available (not returned on every endpoint).
    property total_count : Int32

    @[JSON::Field(key: "count")]
    # Total number of items returned.
    property count : Int32
  end

  class Images
    include JSON::Serializable

    @[JSON::Field(key: "fixed_height")]
    # Data on versions of this GIF with a fixed height of 200 pixels. Good for mobile use.
    property fixed_height : ExtendedImageDataVideo

    @[JSON::Field(key: "fixed_height_still")]
    # Data on a static image of this GIF with a fixed height of 200 pixels.
    property fixed_height_still : ImageData

    @[JSON::Field(key: "fixed_height_downsampled")]
    # Data on versions of this GIF with a fixed height of 200 pixels and the number of frames reduced to 6.
    property fixed_height_downsampled : ExtendedImageData

    @[JSON::Field(key: "fixed_width")]
    # Data on versions of this GIF with a fixed width of 200 pixels. Good for mobile use.
    property fixed_width : ExtendedImageDataVideo

    @[JSON::Field(key: "fixed_width_still")]
    # Data on a static image of this GIF with a fixed width of 200 pixels.
    property fixed_width_still : ImageData

    @[JSON::Field(key: "fixed_width_downsampled")]
    # Data on versions of this GIF with a fixed width of 200 pixels and the number of frames reduced to 6.
    property fixed_width_downsampled : ExtendedImageData

    @[JSON::Field(key: "fixed_height_small")]
    # Data on versions of this GIF with a fixed height of 100 pixels. Good for mobile keyboards.

    @[JSON::Field(key: "fixed_height_small_still")]
    # Data on a static image of this GIF with a fixed height of 100 pixels.
    property fixed_height_small_still : ImageData

    @[JSON::Field(key: "fixed_width_small")]
    # Data on versions of this GIF with a fixed width of 100 pixels. Good for mobile keyboards.
    property fixed_width_small : ExtendedImageDataVideo

    @[JSON::Field(key: "fixed_width_small_still")]
    # Data on a static image of this GIF with a fixed width of 100 pixels.
    property fixed_width_small_still : ImageData

    @[JSON::Field(key: "downsized")]
    # Data on a version of this GIF downsized to be under 2mb.
    property downsized : SizedImageData

    @[JSON::Field(key: "downsized_still")]
    # Data on a static preview image of the downsized version of this GIF.
    property downsized_still : ImageData

    @[JSON::Field(key: "downsized_large")]
    # Data on a version of this GIF downsized to be under 8mb.
    property downsized_large : SizedImageData

    @[JSON::Field(key: "downsized_medium")]
    # Data on a version of this GIF downsized to be under 5mb.
    property downsized_medium : SizedImageData

    @[JSON::Field(key: "downsized_small")]
    # Data on a version of this GIF downsized to be under 200kb.
    property downsized_small : VideoData

    @[JSON::Field(key: "original")]
    # Data on the original version of this GIF. Good for desktop use.
    property original : ExtendedImageDataFrame

    @[JSON::Field(key: "original_still")]
    # Data on a static preview image of the original GIF.
    property original_still : ImageData

    @[JSON::Field(key: "looping")]
    # Data on the 15 second version of the GIF looping.
    property looping : LooperData

    @[JSON::Field(key: "preview")]
    # Data on a version of this GIF in .MP4 format limited to 50kb that displays the first 1-2 seconds of the GIF.
    property preview : VideoData

    @[JSON::Field(key: "preview_gif")]
    # Data on a version of this GIF limited to 50kb that displays the first 1-2 seconds of the GIF.
    property preview_gif : ImageData

    class ImageData
      include JSON::Serializable

      @[JSON::Field(key: "url")]
      # The publicly-accessible direct URL for this GIF.
      property url : String?

      @[JSON::Field(key: "width")]
      # The width of this GIF in pixels.
      property width : String?

      @[JSON::Field(key: "height")]
      # The height of this GIF in pixels.
      property height : String?
    end

    class SizedImageData < ImageData
      include JSON::Serializable

      @[JSON::Field(key: "size")]
      # The size of this GIF in bytes.
      property size : String?
    end

    class ExtendedImageData < SizedImageData
      include JSON::Serializable

      @[JSON::Field(key: "webp")]
      # The URL for this GIF in .webp format.
      property webp : String?

      @[JSON::Field(key: "webp_size")]
      # The size in bytes of the .webp file corresponding to this GIF.
      property webp_size : String?
    end

    class ExtendedImageDataVideo < ExtendedImageData
      include JSON::Serializable

      @[JSON::Field(key: "mp4")]
      # The URL for this GIF in .MP4 format.
      property mp4 : String?

      @[JSON::Field(key: "mp4_size")]
      # The size in bytes of the .MP4 file corresponding to this GIF.
      property mp4_size : String?
    end

    class ExtendedImageDataFrame
      include JSON::Serializable

      @[JSON::Field(key: "width")]
      # The width of this GIF in pixels.
      property width : String?

      @[JSON::Field(key: "height")]
      # The height of this GIF in pixels.
      property height : String?

      @[JSON::Field(key: "size")]
      # The size of this GIF in bytes.
      property size : String?

      @[JSON::Field(key: "frames")]
      # The number of frames in this GIF.
      property frames : String?

      @[JSON::Field(key: "mp4")]
      # The URL for this GIF in .MP4 format.
      property mp4 : String?

      @[JSON::Field(key: "mp4_size")]
      # The size in bytes of the .MP4 file corresponding to this GIF.
      property mp4_size : String?

      @[JSON::Field(key: "webp")]
      # The URL for this GIF in .webp format.
      property webp : String?

      @[JSON::Field(key: "webp_size")]
      # The size in bytes of the .webp file corresponding to this GIF.
      property webp_size : String?
    end

    class VideoData
      include JSON::Serializable

      @[JSON::Field(key: "mp4")]
      # The publicly-accessible direct URL for this GIF.
      property mp4 : String?

      @[JSON::Field(key: "width")]
      # The width of this GIF in pixels.
      property width : String?

      @[JSON::Field(key: "height")]
      # The height of this GIF in pixels.
      property height : String?

      @[JSON::Field(key: "mp4_size")]
      # The size of this GIF in bytes.
      property mp4_size : String?
    end

    class LooperData
      include JSON::Serializable

      @[JSON::Field(key: "mp4")]
      # The URL for this GIF in .MP4 format.
      property mp4 : String?
    end
  end
end