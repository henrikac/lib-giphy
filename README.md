# lib-giphy

A library that makes it easy to interact with the [GIPHY API](https://developers.giphy.com/).

## Requirements

To get the API key that is required to create a new `Giphy::Client` you need to create a GIPHY app.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     lib-giphy:
       github: henrikac/lib-giphy
   ```

2. Run `shards install`

## Usage

```crystal
require "giphy"

giphy = Giphy::Client.new <api_key>

gifs = giphy.search("cats") # => returns 25 gifs
trend_gifs = giphy.trending() # => returns 25 gifs
translated = giphy.translate("cats") # => returns 1 gif
random_gif = giphy.random() # => returns 1 gif

gifs.data.each do |gif|
  puts gif.title
end
```

Each `Giphy::Client` method can also takes a `Param` object.  
Different types of `Param`:
* `SearchParam`
* `TrendingParam`
* `TranslateParam`
* `RandomParam`

## Contributing

1. Fork it (<https://github.com/henrikac/lib-giphy/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Henrik Christensen](https://github.com/henrikac) - creator and maintainer
