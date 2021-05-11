#!/bin/bash
#a small script to download json data used for testing 
curl "https://api.giphy.com/v1/gifs/search?api_key=${GIPHY_API_KEY}&limit=25&offset=0&q=cats" | jq > search-default.json
curl "https://api.giphy.com/v1/gifs/search?api_key=${GIPHY_API_KEY}&limit=1&offset=0&q=cats" | jq > search-limited.json
curl "https://api.giphy.com/v1/gifs/trending?api_key=${GIPHY_API_KEY}&limit=25&offset=0" | jq > trending-default.json
curl "https://api.giphy.com/v1/gifs/trending?api_key=${GIPHY_API_KEY}&limit=5&offset=500" | jq > trending-limited.json
curl "https://api.giphy.com/v1/gifs/translate?api_key=${GIPHY_API_KEY}&weirdness=0&s=baked+beans" | jq > translate-default.json
curl "https://api.giphy.com/v1/gifs/random?api_key=${GIPHY_API_KEY}" | jq > random-default.json
curl "https://api.giphy.com/v1/gifs/xT4uQulxzV39haRFjG?api_key=${GIPHY_API_KEY}" | jq > get-by-id.json
curl "https://api.giphy.com/v1/gifs?api_key=${GIPHY_API_KEY}&ids=xT4uQulxzV39haRFjG,3og0IPxMM0erATueVW" | jq > get-by-ids.json
curl "https://api.giphy.com/v1/gifs/categories?api_key=${GIPHY_API_KEY}" | jq > get-categories.json



