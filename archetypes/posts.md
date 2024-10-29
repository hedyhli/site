+++
{{ $title := slicestr (replace .Name "-" " ") 11 -}}
title = {{ $title | title }}
description = {{ strings.FirstUpper $title }}
tags = []
highlight = false
draft = true

date = {{ time.Now.UTC.Format "2006-01-02T15:04:05Z" }}
outputs = ['html', 'gemini']
# Filename after the date
slug = {{ slicestr .Name 11 }}
# The "EOF" after the hr at the end of a post.
# Generally: disable if footnotes are used, enable otherwise to signify the end.
EOF = true
+++


