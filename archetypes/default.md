---
title: "{{ slicestr (replace .Name "-" " ") 11 | title }}"
date: {{ .Date.Format "2006-01-02" }}
draft: true
outputs:
  - html
  - gemtext
slug: {{ slicestr .Name 11 }}

---

