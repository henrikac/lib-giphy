require "json"

module Giphy
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
end