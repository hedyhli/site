+++
title = "Default Apps 2024"
description = "Software I appreciate. Or, long lists of apps I would include if I had a /uses page."
date = "2024-12-31T12:48:06Z"

draft = false
outputs = ['html']

slug = "default-apps"
tags = []

highlight = false
# font = "mono"

# [[syndications]]
# mastodon =
# bluesky =
+++

I don't have a dedicated `/uses` page; only a little table on my [about](/about/) page that lists the development-related essentials. Since today is the last day of 2024, I decided to jump on the "default apps" trend and listing the primary software I use as of today for each common task. I'll also include notes where there was a recent update to the list of significance.

## General

- **Launcher**: Alfred <br />
  I use Alfred only for launching applications; it's much faster than the catch-all MacOS Spotlight Search.
- **Books**: Kindle Paperwhite and Goodreads (I do have a [bookwyrm account](https://tildebooks.org/user/hedy) if you'd like to follow my updates from the Fediverse :)
- **Podcasts**: Pocket Casts
- **Music**: InnerTune

## Productivity

- **Notes**: [Logseq](https://logseq.com/) for research, [Memos](https://usememos.com/) (self-hosted) for personal micro-blogging, and Notion for others
- **Writing**: [Obsidian](https://obsidian.md)
- **Todos**: Todoist

Notion gives me sync with zero overhead in the free tier and its mobile apps have slightly better UX than Logseq (which is still reletively young). Logseq is an outliner, and I personally find it especially suited for certain kinds of note-taking for some of my research. I also use it for long-term personal project task management that integrates well with the journal feature.

Unfortunately, Logseq isn't quite fit for long-form writing and drafting; so I'm currently exploring syncing options -- possibly using Syncthing or Git repositories -- with Obsidian.

I've considered using Org-mode with Emacs on the desktop and Orgzly on mobile, however Org is a little to complex for my needs (it's true, perhaps I'm just not patient enough to overcome the learning curve) and much prefer something I can more easily manage and wrap my head around. Markdown has a wider range of support and can be converted to blog posts under my currently setup easier. If I ever decide to switch to Org for <abbr title="Personal Knowledge Management">PKM</abbr>, I might opt for [denote](https://protesilaos.com/emacs/denote) or [HOWM](https://kaorahi.github.io/howm/) as companions.

## Internet

- **Web browser**: Vivaldi (graphical), [w3m (textual)](https://home.hedy.dev/posts/the-joy-of-feed-readers/#alternative-browsers)

  I've tried many graphical web browsers in the past, enough to write a long "browser reviews" post (it's planned!) <br />

  I like Vivaldi for its vertical tabs, extension customization support, built-in indicator for detected RSS/Atom feeds, and the reader mode. I disable its other features such the feed reader, calendar, notes, and mail client and would personally prefer the Firefox backend, but Vivaldi is currently the best option for personal use.

- **[Gemini](https://geminiquickst.art) (and Gopher) client**: [gelim](https://github.com/hedyhli/gelim) and Lagrange
- **Bookmarks**: Raindrop <br />
  I save web bookmarks in raindrop using the browser extension and mobile apps, then I export it with a script that display my public bookmarks [here on my website](https://home.hedy.dev/bookmarks/).
- **Read-it-later**: Instapaper
- **RSS/Atom Feed reader**: [yarr!](https://github.com/nkanaev/yarr) (self-hosted, PWA)
- **Search**: DuckDuckGo for its [bangs](https://duckduckgo.com/bang)
- **Email service**: Proton Mail
- **Email client**: Proton Mail and [aerc](https://aerc-mail.org) (for other emails)
## Social Media

- **Reddit client**: [Red Reader](https://github.com/QuantumBadger/RedReader) (android)
- **Mastodon client**: [Phanpy](https://phanpy.social/) (PWA[^PWA])
- **Pleroma/Akkoma client[^pleroma]**: Husky (android)
- **Bluesky client**: the official web client as a PWA <br />
  I used to use [TOKIMEKI](https://tokimeki.blue/), but some Bluesky features such as starter-packs prefers to open links in its official client instead, so I've switched away from TOKIMEKI until the situation improves.
- **IRC client**: [senpai](https://sr.ht/~delthas/senpai/) and [gamja](https://codeberg.org/emersion/gamja)
- **IRC bouncer**: soju on [SourceHut](https://man.sr.ht/chat.sr.ht/)
- **Matrix client**: [Cinny](https://cinny.in/)
- **Lemmy[^lemmy] client**: [Voyager](https://vger.app/) (mobile)

[^PWA]: Progressive Web App. In this context, it means I have the web app "installed" on mobile using -- what is usually called -- the "add to home screen" feature.

[^lemmy]: A reddit alternative part of the fediverse. See [Lemmy on Wikipedia](https://en.wikipedia.org/wiki/Lemmy_(social_network)).

[^pleroma]: [Pleroma](https://pleroma.social/) and [Akkoma](https://akkoma.social/) can be thought of as alternatives to Mastodon.

## Development

Configuration and scripts of interest for everything I use in the terminal can be found in my [dotfiles](https://github.com/hedyhli/dotfiles).

- **Editor/IDE**: NeoVim, Emacs (for Lisps and [occasionally](https://smol.hedy.dev/re-baty-emacs-from-scratch) Org-mode)
- **Terminal**: Kitty
- **Shell**: Fish
- **File manager**: ranger
- **Multiplexer**: tmux (I've tried Zellij, but I did not have a good experience with WASM plugins; perhaps I should write about it sometime)
- **Dotfiles manager**: yadm


Welp, I can only seem to maintain long lists like these once a year... I remember now, why I don't have a `/uses` page! ;)
