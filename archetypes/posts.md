+++
{{ $title := slicestr (replace .Name "-" " ") 11 -}}
title = {{ $title | title }}
description = {{ strings.FirstUpper $title }}
highlight = false
draft = true

date = {{ .Date.Format "2006-01-02T15:04:05Z" }}
draft = true
outputs = ['html', 'gemtext']
# Filename after the date
slug = {{ slicestr .Name 11 }}
# The "EOF" after the hr at the end of a post.
# Generally: disable if footnotes are used, enable otherwise to signify the end.
EOF = true
+++


