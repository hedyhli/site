---
{{ $title := slicestr (replace .Name "-" " ") 11 -}}
title: {{ $title | title }}
description: {{ strings.FirstUpper $title }}
highlight: false
draft: true

date: {{ .Date }}
outputs:
  - html
  - gemtext
slug: {{ slicestr .Name 11 }}

---

