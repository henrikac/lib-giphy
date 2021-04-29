require "json"
require "./gif"
require "./meta"
require "./pagination"

module Giphy
  class CategoryCollection
    include JSON::Serializable

    @[JSON::Field(key: "data")]
    property data : Array(Category)

    @[JSON::Field(key: "pagination")]
    property pagination : Pagination

    @[JSON::Field(key: "meta")]
    property meta : Meta
  end

  class Category
    include JSON::Serializable

    @[JSON::Field(key: "name")]
    # Category name.
    property name : String

    @[JSON::Field(key: "name_encoded")]
    # Encoded category name.
    property name_encoded : String

    @[JSON::Field(key: "subcategories")]
    # List of subcategories.
    property subcategories : Array(Subcategory)

    @[JSON::Field(key: "gif")]
    # Featured gif for category.
    property gif : GifData
  end

  class Subcategory
    include JSON::Serializable

    @[JSON::Field(key: "name")]
    # Category name.
    property name : String

    @[JSON::Field(key: "name_encoded")]
    # Encoded category name.
    property name_encoded : String
  end
end