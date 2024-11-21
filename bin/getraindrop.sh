#!/usr/bin/env bash

curl -H "Authorization: Bearer ${RAINDROP_TOKEN}" https://api.raindrop.io/rest/v1/raindrops/0 | jq '.items | map(select(.tags[] | contains("bm"))) | map({link, created, tags, note, excerpt, title})' > assets/data/bookmarks.json
