#!/usr/bin/env bash

curl -H "Authorization: Bearer ${RAINDROP_TOKEN}" 'https://api.raindrop.io/rest/v1/raindrops/50803386?perpage=50' | jq '.items | map({link, created, tags, note, excerpt, title, domain})' > assets/data/bookmarks.json
