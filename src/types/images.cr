require "json"

module Giphy
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