+++
date = '2024-11-05'
description = 'Site Meta'
outputs = ['html']
title = 'A peek behind the curtains: a colophon'
+++

This is my personal website. It is crafted with love and dedication and I try my
best to make it work the way I want it to look on all web clients I can get my
hands on. Generally, this includes about five desktop GUI browsers, three web
engines, and a handful of TUI clients.

My personal site is where I explore accessibility and web design and experiment
with how far I can go with sticking with a `border-radius` of 0. I also write
[blog posts](/posts/), share [interesting links](/bookmarks/), shoutout to [cool
blogs](/blogroll/), among other things.

This page talks about how I do all of that.

{{% callout note %}}

This is a `/meta` page. You should consider [adding your
own](/posts/meta-pages/) and documenting changes to your site too :)
{{% /callout %}}

<br />
<hr />

## Overview

My website is statically generated by [Hugo](https://gohugo.io) and
hosted with Netlify. My gemini capsule, which is generated from the same
source is hosted by Sourcehut Pages and is available at
[gmi.hedy.dev](gemini://gmi.hedy.dev/) ([What is
gemini?](https://geminiquickst.art)). The source code is available on
[GitHub](https://github.com/hedyhli/site).

It currently supports a few [microformats](https://microformats.org/) and I plan
on adding more, including other [IndieWeb](https://indieweb.org/) features.

This site supports [webmentions](https://en.wikipedia.org/wiki/Webmention); you
can use the form at the end of each post to manually send me a notification if
you have authored content that referenced one of my posts.

To share your thoughts on a given topic or give general comments, however, I
prefer corresponding via [email](/about/).

Features on the site and certain content such as link gardens and blogrolls are
largely inspired by ideas from the IndieWeb and the [32Bit
Cafe](https://32bit.cafe/). This website primarily hosts my [blog](/posts/),
which you can subscribe to using RSS or Atom feeds listed [here](/feeds/).

Accessibility is a priority, sometimes at the expense of certain UI design
choices, though there are still some places I can do better on. I mostly test my
site on my primary GUI browser and my primary TUI browser. Sometimes, I run it
through validations and tests such as Lighthouse.


## Posting

Most of my posts are mirrored on Gemini. Some are converted from markdown by
hand, others using a conversion tool and editorized manually. I plan to write a
custom script that can convert markdown to gemtext without manual intervention
as part of a new custom SSG I'm working on. I manually submit new gemlog posts
on Antenna, and sometimes announce it on my [fediverse
account](https://tilde.zone/@hedy), especially if I'm currently participating in
[#100DaysToOffload](https://100daystooffload.com/) or other writing challenges.

I write my drafts in [Obsidian](https://obsidian.md/) with a live-preview
markdown editor and the iA Writer Duo font. The Obsidian vault I use serves both
as a drafting environment and as a digital journal. Some posts might end up here
on my website, in which case, I would create a new post with a shell script,
paste the markdown, locally build, and finally publish in a single command. My
publishing process is simply git-pushing to a remote repository that
automatically deploys to netlify.

## Fonts

The following fonts are used on this site:
- [IBM Plex Sans and Mono](https://github.com/IBM/type)
- [iA Writer Duo](https://github.com/iaolo/iA-Fonts)

All written primary content for reading uses IBM Plex Sans, except for some blog posts
which is displayed in iA Writer Duo. IBM Plex Mono is used for all code snippets
and code blocks.

## Colors

The color scheme used throughout the site is inspired by
[Catppuccin](https://catppuccin.com/) themes, adjusted for better contrast and
certain stylistic choices. The theme used for syntax highlighting code blocks
use Catppuccin Latte in light mode and Catppuccin Mocha in dark mode, both are
adjusted to satisfy at least [WCAG AA
rating](https://developer.mozilla.org/en-US/docs/Web/Accessibility/Understanding_WCAG/Perceivable/Color_contrast)
for contrast.

## Webrings

This site is a part of several [Webrings](https://en.wikipedia.org/wiki/Webring). Navigation links for all of them are listed [at `/`](/).

Orbits [my gemini capsule](gemini://gmi.hedy.dev/) is part of is also listed on
its homepage.

## Member sites and badges

This site is also part of several "website clubs" and directories.

<a href="https://512kb.club"><img class="no-dim" height="30" src="https://512kb.club/assets/images/green-team.svg" alt="a proud member of the green team of 512KB club" /></a>
<div class="badges">
<a href='https://www.beepbird.net/index.html'><img src="https://www.beepbird.net/webring/focusfirst.png" alt="Focus First Index"></a>
<a href='https://notbyai.fyi/'><img src="/created-by-human_white.png" alt="Created By Human, Not By AI"></a>
<a href='https://kalechips.net/responsive/index'><img src="https://kalechips.net/responsive/buttons/8831-1.png" alt="Responsive Web Directory"></a>
<a href='https://pinkvampyr.leprd.space/accessiblenet/index'><img src="https://www.beepbird.net/outlinks/badges/accessible-net.webp" alt="Accessible Net Directory"></a>
</div>
<a href="https://www.htmlhobbyist.com/"><img class="no-dim" src="https://www.htmlhobbyist.com/images/html-hobbyist-badge.svg" height="100" width="100" alt="I am an HTML Hobbyist" /></a>

Feel free to [let me know](/about/) if you'd like me to join your webring or
directory.

## Changelog

Newest entries are listed first.

{{% changelog %}}
