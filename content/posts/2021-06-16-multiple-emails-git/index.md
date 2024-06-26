+++
date = '2021-06-16T23:50:00Z'
description = 'How to have different git author configurations depending on the computer and have it tracked with dotfiles.'
draft = false
highlight = true
outputs = ['html', 'gemtext']
slug = 'multiple-emails-git'
tags = ['howto', 'git']
title = 'Multiple emails in git for different computers'
+++

As someone who code on multiple machines to work on different projects, I like to commit with different emails.

I don't know how everyone else handle different emails in .gitconfig *and* track dotfiles in a git repo at the same time, but here's the solution I've come up with.

First, I have a global ~/.gitconfig with the default user email and some other global settings (by global I mean same cross different computers I work on).

```ini
# ~/.gitconfig
[user]
name = Default Name
email = me@default.email
```

Then for each machine I have a ~/.gitconfig-local file which can override some settings just for that machine, such
as email, signing key, editor, etc.

```ini
# ~/.gitconfig-local
[user]
email = me@special.email
```

Back in the global ~/.gitconfig, I have this snippet that tells git to also look for configuration in my ~/.gitconfig-local:

```ini
# ~/.gitconfig
[include]
path = ~/.gitconfig-local
```

Here, I can have ~/.gitconfig tracked in my dotfiles repo, but I do not have ~/.gitconfig-local tracked. This way, I can put anything I like specific to a particular machine in the ~/.gitconfig-local, as well as SMTP settings such as password, which you wouldn't want to end up in a public git repo.

As to setting it up on a new machine, I have a setup script in my dotfiles repo that creates an empty ~/.gitconfig-local. I use this same method with fish configs -- global config and a local config, you can have a look at them in my [dotfiles repo](https://git.sr.ht/~hedy/dotfiles/) on sourcehut.
