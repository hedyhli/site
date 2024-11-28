+++
title = "Webmentions"
description = "How I've added Webmentions to my site over the years, and my general thoughts on the protocol."
date = "2024-11-28T01:09:55Z"

draft = false
outputs = ['html']

slug = "webmentions"
tags = ['meta']

highlight = true
# font = "mono"

# [[syndications]]
# list =
# mastodon =
+++


Webmention is a system in which other websites can notify you that when their site has mentioned a page on your site. It originated from the [IndieWeb](https://indieweb.org/Webmention) and is now a [W3C Recommendation](https://www.w3.org/TR/webmention/).

To receive Webmentions, your site needs to expose an endpoint that will collect these Webmentions in a server, and link to it in a `<link rel="webmention" href="[endpoint]">` tag in your `<head>`. This endpoint can be self-hosted (such as [webmentiond](https://webmentiond.org/)), or with a service such as [webmention.io](https://webmention.io).

Someone that mentioned your site submits a POST request with a `source` parameter as the URL of their site, and the `target` parameter being the URL on your site which they linked.

You can then choose to display a list of all Webmentions of a particular page at the bottom of each page on your site, or simply get a notification and move on.

This seems simple. And it probably is if your blogging platform supports it without any overhead. But for hand-crafted personal sites with your own suite of tools -- possibly statically-generated -- implementing Webmentions is a bit more involved.

I set out to support Webmentions on my blog a few years ago with these goals:
- Webmentions I receive should go through manual approval before they can be displayed;
- Webmentions I receive also should have been automatically verified before being listed for manual approval (such as checking the `source` and `target` or legitimate, and that the `source` actually does link to the `target`);
- When I send Webmentions to pages I mention, the process should be automatic (such as on each deploy);
- A website should not be pinged twice for the same page on my site that mentions it;
- Display approved Webmentions so readers can continue reading further discussion (if there is any) after finishing a blog post.

In this post, I'll walk you through the several stages of my Webmention support, revisit the list above as a checklist on each stage, and share with you my thoughts on Webmention and the eventual direction I went with Webmention support.


## 1. Receiver

I initially supported Webmentions by simply signing up on [webmention.io](https://webmention.io), a free service that lets you receive Webmentions from other people. It's made by [Aaron Perecki](http://aaronparecki.com/), the author of the Webmentions specification.

In my site's `<head>`, I included a link to the endpoint I was provided with from webmention.io:

```html
<link rel="webmention" href="https://webmention.io/home.hedy.dev/webmention">
```

This was enough for my website to receive Webmentions, should someone choose to send them.

I could use the API at `https://webmention.io/api/mentions.html?target=<page-URL>` to view Webmentions for a given page on my website, and I can also automatically show a link to it at the end of each blog post on my website to save the hassle of parsing and display the entries myself.

At this stage, I did not consider sending Webmentions for other people.

- [x] Manual approval: I could delete entries from the <webmention.io> dashboard and only include a public link that displays the list of Webmentions after all remaining entries are approved.
- [x] Automatic verification: This was handled by <webmention.io>.
- [ ] Automatic sending of Webmentions for changes on my site.
- [x] A website should not be pinged twice for the same page on my site that mentions it;
- [ ] Display approved Webmentions: well, somewhat, but not so much as I hoped for at the time.


## 2. Sending Webmentions

I decided that I should probably send some Webmentions to people, surely it takes less effort than writing a personalized email?

My site was (and still is) statically generated with Hugo. I found out about [static-webmentions](https://github.com/nekr0z/static-webmentions), the right tool for the job, and decided to give it a go.

After installing and adding the relevant configuration to my `config.toml`, I ran `static-webmentions find`.

It did not exit for several minutes, without producing any output. I noticed there was a new `mentions.json` file. Perhaps that was enough? I ran `static-webmentions send`, it crashed with a trace-back log of Goroutines.

I looked through the default configuration, added `concurrentFiles = 1` and `concurrentRequests = 1`, and `static-webmentions send` worked... for some reason.

It produced a lot of output, showing me the sites it tried (and failed) to find a Webmention endpoint for. Sites that included my own and sites that aren't even using the HTTP(S) protocol. I updated my list of excludes in `config.toml` and tried again.

More output.

Hang on... wouldn't that send repeated Webmentions to sites it has previously successfully sent to?

I checked the docs again. Looks like it did support watching for new changes using an `oldDir` and `newDir` directories. Luckily, I kept a previous deployment locally. I updated `config.toml`, but since I hadn't updated anything between the two runs, it would not detect any new Webmentions this (third) time around.

Well, guess I'd test it out the next time I updated my website.

## 3. Display Webmentions

As I started to share links from my site elsewhere on the internet, I decided that I should try display Webmentions.

I found out about the [brid.gy](https://brid.gy) service which could connect your website to social media and send you Webmentions when someone likes or comments on a post that links to your website. I had it set up, and started receiving more Webmentions.

To display Webmentions, I was initially fetching from the API provided by webmention.io. The Webmentions that brid.gy sends provided more data than simply a `source` and `target` field because they were really interactions such as likes and comments rather than simply mentioning links.

This was fine, I didn't need to handle likes and comments from sources other than brid.gy as I was yet to receive any. I wrote HTML templates that will display all those Webmentions nicely like a comment section on a forum site.

Oops, Fediverse custom emotes were showing as full width images! I fixed those with CSS. But they didn't have any semantic information that could differentiate them from actual images, and so all images would show as emotes...

The only solution I could think of was to edit the comment data to add a custom `class="emoji"`. Which meant I had to save the JSON data from the webmention.io API locally. I made a script with some `jq`-fu to extract the relevant data, then manually merged new data with existing (edited) data manually when new Webmentions arrive every time.

This was't too bad. An ad-hoc approval process that checks one of the receiver requirement boxes!

But even if I could get the entire process streamlined with a script, I'd still have to store the approved Webmentions somewhere if it wasn't on webmention.io's servers, in case I lose those files locally. It doesn't fit to track them in Git along with my site repo, so I decided to deploy it to a temporary static site (such as [pgs.sh](https://pgs.sh)) before each deploy.

Again, that wasn't *too* bad.

A review of the third pass:
- [x] Manual approval: I could delete entries from the webmention.io dashboard like before, but this time, the JSON data has to go through a script, from which I copy the result and manually merge it with existing Webmentions. This means I was incentived to wait for a batch of Webmentions before merging it and rebuilding my site to display the new entries.
- [x] Automatic verification: Again, this was handled by webmention.io.
- [ ] Automatic sending of Webmentions for changes on my site.
- [x] A website should not be pinged twice for the same page on my site that mentions it;
- [x] Display approved Webmentions: not so timely though, due to what I've described in the first checklist item.


## 4. Sender, v2

Some time later, I changed my deployment set up and a fully representative `oldDir` for `static-webmentions` was no longer possible.

Without an `oldDir`, it would send *all Webmentions* for *all pages*  on each invocation. Not only would this be a waste of resources, it would also drastically increase the time needed for each deployment, even if I just needed to quickly update a typo.

To make matters worse, `static-webmentions` kept crashing even with the `concurrentFiles = 1` workaround that previously worked. I had no choice but to look for alternatives.

From the [IndieWeb Wiki page for Webmentions](https://indieweb.org/Webmention), I found a number of tools that were said to make sending Webmentions easy. Unfortunately, a good portion of them were unmaintained, and about half do not work with my setup.

I found one tool that lets you submit a link to a web page, and it handles attempting to send Webmentions for all linked sites on the page, made by none other than Aaron Parecki of webmention.io, called [Telegraph](https://telegraph.p3k.io/).

This service made it easy to send new Webmentions when I publish new posts or create new pages -- I could just submit the link of the new page. When I edit existing pages I could also submit a manual `source` and `target` and it would handle the discovery of Webmention endpoints for me.

As I started to receive Webmentions from brid.gy more frequently, I found myself using my previous setup for the receiver a lot less. I could check Webmentions easily, but fetching and processing new Webmentions just so they could be displayed at the end of each blog post was quite involved.

The reason I displayed Webmentions in the first place was for readers to have easy access to discussion and responses surrounding a blog post for further reading after finishing a post on my blog. This usually meant the Fediverse or other social media links, or link aggregators.

I decided that it wasn't worth all the work making all the Webmentions display the way I want on my site. I could link to the specific Mastodon or link-aggregator post instead, and readers can view the interactions and comments displayed at the original source. It only added a single extra click, and it was a little weird to show 3rd party content right under my own post on a personal site.

Furthermore, despite all the controversy regarding different servers seeing a different set up of replies and different number of likes/reposts, Fediverse web clients will always be more up to date than my blog. Trying to parse brid.gy's Webmentions and displaying it sensibly was re-inventing the wheel.

I ditched displaying Webmentions altogether and resorted to updating my site when I get notified of a new Webmention to link to that site at the end of a post.

A review of this pass:
- [x] Manual approval: nothing is approved until I manually link to mentions on my site;
- [x] Automatic verification;
- [x] Automatic sending of Webmentions for changes on my site: not completely automatic, but I just need to submit the link of the new page;
- [x] A website should not be pinged twice: Telegraph shows a list of previously sent Webmentions;
- [x] Display approved Webmentions.

## Conclusion

If Webmentions remained what was originally envisioned -- a simple `source` mentioning a `target` -- things would be a lot better. This change doesn't improve the sender situation, but it certainly makes it easier to receive and display Webmentions.

I have never tried the Webmention support on hosted blogging platforms such as Wordpress, nor have I used `webmentiond` (it self-hosting, as well as a mail server, which isn't possible for many blogging hobbyists), but from my experience with implementing Webmentions on my statically generated site, receiving Webmentions is easy, sending and displaying them, not so much.

For now, I will be keeping my implementation the way I described in the fourth pass. It's unlikely this setup will change in the foreseeable future.

My preferred method of communication is email, and I would encourage you to use the "Reply via Email" link at the end of the each post to send me your thoughts and suggestions (though there is a form to send Webmentions manually too, if you prefer). Even if you're only notifying me of a response to my post on your site. It's personal, it's customized, and it's less likely to get loss.
