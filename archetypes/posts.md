+++
{{ $title := slicestr (replace .Name "-" " ") 11 -}}
title = "{{ $title | title }}"
description = "{{ strings.FirstUpper $title }}"
date = "{{ time.Now.UTC.Format "2006-01-02T15:04:05Z" }}"

draft = false
outputs = ['html', 'gemtext']
{{/* Filename after the date */}}
slug = "{{ slicestr .Name 11 }}"
tags = []

highlight = false
# font = "mono"

# [[syndications]]
# mastodon =
# bluesky =
+++


