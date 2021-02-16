---
title: "{{ slicestr (replace .Name "-" " ") 11 | title }}"
date: {{ .Date }}
draft: true
outputs:
  - html
  - gemtext
---

