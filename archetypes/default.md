+++
title = "{{ replace .Name '-' ' ' | title }}"
date = "{{ time.Now.UTC.Format "2006-01-02" }}"
draft = true
outputs = ['html', 'gemtext']
slug = "{{ .Name }}"
+++


