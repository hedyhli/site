+++
date = '2021-02-23'
description = 'A walkthrough of my workflows for the site and a gentle introduction to tilde.cafe and the Tildeverse.'
draft = false
outputs = ['html', 'gemtext']
tags = ['meta']
slug = 'site-meta'
title = 'How this site works'
+++

<details open="">
<summary>2023 Update</summary>

I started writing this post on 2021, February 23 but I never completed it. So in
2023 I decided to finish up this outstanding post and get it done with.
Surprisingly, the content did not change much other than moving from ~team to
~cafe (more on that later). I still use Hugo and write in Markdown. And I still
publish to both WWW and Gemini.

Excuse the odd placing of this post, but otherwise, enjoy the read~

</details>

<details open="">
<summary>2024 March Update</summary>

I no longer host my website, gemini capsule and spartan content on tilde.cafe.
As of writing, I've switched to srht.site for static HTTPS/gemini hosting with
my own domain at home.hedy.dev.

I'm keeping this post (which as it turns out, I still never got to publish) as
a historical record, whose information, other than the aforementioned
differences, remains mostly accurate.

</details>

<br />

This is where my gemlog/blog lives. It is statically generated
with [Hugo](https://gohugo.io/) and rsync-ed to my `public_html` and `public_gemini`
directories for HTML and gemini on [tilde.cafe](https://tilde.cafe) respectively
on build.

The site source is always linked at the footer, pointing to the [sourcehut
repo](https://sr.ht/~hedy/site) though the repo is also mirrored on
[github](https://github.com/hedyhli/site).


## tilde.cafe and the Tildeverse

> [The [Tildeverse](https://tildeverse.org) is] a loose association of
> like-minded tilde communities. *Tildes* are pubnixes in the spirit of
> [tilde.club](https://tilde.club/), which was [created in 2014 by Paul
> Ford](https://medium.com/message/tilde-club-i-had-a-couple-drinks-and-woke-up-with-1-000-nerds-a8904f0a2ebf)

A **Pubnix** is a Public Access Unix System — in other words, a unix machine on
the internet that provides access to other people on the internet — which
started before WWW and even the public internet. Pubnixes you may have heard of
[SDF](https://sdf.org),
[Circumlunar.Space](https://portal.mozz.us/gopher/circumlunar.space/), and
[tilde.club](https://tilde.club).

[~cmccabe](https://tilde.team/~cmccabe/) has a [Pubnix History
Project](https://gopher.mills.io/rawtext.club/1/~cmccabe/pubnixhist/) for you to
explore if you're interested in learning more about pubnixes.

There are a lot of pubnixes that have joined the Tildeverse since the the ~club
and [~team](https://tilde.team) (which hosts the tildeverse website together
with many services).

Most tildes have open registerations. Users are provided around 1 GB of disk
space along with SSH access and are able to host their own static site with CGI
under the main tilde domain, together with services like email, gemini/gopher
hosting, pastbin, and more.

However, the true value of tildes lie not in the services they provide but the
people and community. The tildeverse has an official IRC network, tilde.chat,
which most tildes use for their main channel of communication. They also have a
[radio](https://tilderadio.org), a [mastodon instance](https://tilde.zone),
[gitea instance](https://tildegit.org), among other services. The latter two
from the above are both hosted by [~ben](https://ben.tilde.team) the owner of
~team.

I chose to host my personal website on tilde.cafe, a (relatively) newer tilde
that runs on Debian with a smaller user base, and for the past two years most
coding projects I had done were developed on ~Cafe's server. It's grown to
become my second digital home on the internet ever since I started to use hedy
at tilde.cafe for my primary email.

It was fun to work with ~cafe admins [~spider](https://tilde.cafe/~spider/) and
[~jan6](https://tilde.cafe/~jan6) in the early days, helping to set up and write
the [wiki](https://tilde.cafe/wiki/) and automated website builds. We used the
 #cafe channel on tilde.chat for our main chat.

Some time in 2021 or 2022, jan6 is no longer able to chat with us on #cafe in
tilde.chat, and since spider became busy with work and other areas of life, we
needed one more admin to take care of user support on tilde.cafe. I was
promoted to join spider and jan6 as sudoers and have been helping with signups
and sysadmin'ing since then.

I don't plan to move off ~cafe to host my personal website, nor email in the
foreseable future. Though when I have side-projects that required dedicated
servers with subdomains, I will consider using my own server and domain. Until
then, I remain eternally grateful to ~cafe and other tilde-owners for
maintaining awesome communities and providing welcoming spaces online for
strangers to come together and build cool stuff, with money from the admin's own
pockets.

If you're someone who is recently discovering the tildeverse I highly recommend
[rawtext.club](https://rawtext.club) (though not a "tilde" but a very cool
community of extremely interesting people), [~team](https://tilde.team) (they
have a welcoming chat — #team — easily second most active channel on
tilde.chat), [~envs](https://envs.net) (they have an [Akkoma
instance](https://pleroma.envs.net), used by Rohan Kumar from
[seirdy.one](https://seirdy.one) whose articles you may have come across on the
internet), and of course [~cafe](https://tilde.cafe) (drop me an
email if you registered after reading this and I'll make sure to personally
approve your sign-up ;P). Others may not agree on my choices so this is not at
all to downplay the worth of [other tildes](https://tildeverse.org/members/):
there's almost no harm in having an account on every single one, though you can
definitely meet some cool people!


## Software stack & workflows

No javascript is used. All content is written in Markdown and Gemtext, with the
static HTMl output generated by Hugo. The styling is done with vanilla CSS,
[syntax highlighting](/posts/hugo-syntax-highlighting/) provided by chroma.

When a new blog post is written, I would ensure both markdown and gemtext
sources are done, then I would run `make` which uses Hugo and does some
miscellaneous cleaning-up to produce HTMl files at `~/public_html` and gemtext
at `~/public_gemini`. I then use a browser to access the folder locally to check
that everything is working. When something needs updating, a single `make` is
enough to rebuild the entire site.

Finally, I commit and push. If I wasn't working on ~cafe directly I would next
log into ~cafe, pull, and `make` from there. It's guaranteed to perform the same
from my home computer and on ~cafe given the same Hugo versions.

Since I ran `make` on ~cafe, the actual `~/public_*` directories will be updated
on the changes would be live! 🎉

~cafe web server handles the rest. (FTR: on WWW we use nginx and on Gemini we
use Gemserv.)


## Hosting

The site and gemini capsule is to be accessed at `hedy.tilde.cafe`; it works on
both protocols. You may be curious how we could have per-user vhosts on gemini —
no, there is no built-in configuration option as of writing. This is done with a
shell script that appends to config file a separate server configuration when a
new user sign-up is approved, written by jan6.

The `<user>.tilde.cafe` vhost is also supported on
[spartan](https://portal.mozz.us/gemini/spartan.mozz.us). I wrote the spartan
server that cafe uses ([spsrv](https://github.com/hedyhli/spsrv)) and it
provides a config option to use per-user vhosts.

