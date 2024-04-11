+++
title = "{{ replace .Name "-" " " | title }}"
date = {{ .Date }}
draft = true
outputs = ['html', 'gemtext']
slug = {{ .Name }}
+++


