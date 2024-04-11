+++
{{ $title := slicestr (replace .Name "-" " ") 11 -}}
title = {{ $title | title }}
description = {{ strings.FirstUpper $title }}
highlight = false
draft = true

date = {{ .Date }}
draft = true
outputs = ['html', 'gemtext']
slug = {{ slicestr .Name 11 }}
+++


