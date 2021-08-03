---
title: "On rants about gemini"
date: 2021-02-05T23:36:00Z
draft: false
tags:
  - gemini
outputs:
  - html
  - gemtext
---

Recently there've been some discussions about how Gemini "doesn't fix anything" on Lobste.rs:

* [Why Gemini is Not My Favorite Internet Protocol](https://lobste.rs/s/vhlagb/why_gemini_is_not_my_favorite_internet)
* [Gemini is Useless](https://lobste.rs/s/3nsvkk/gemini_is_useless)

As well as a few posts related to that on smol.pub:

* [bentsai.smol.pub/embracing-constraints](//bentsai.smol.pub/embracing-constraints)
* [mieum.smol.pub/for-the-love-of-gemini](//mieum.smol.pub/for-the-love-of-gemini)

I think that those comments on Lobsters can be summarized into these main points:

* We don't need a whole new protocol (and the corresponding new software) just because most of the web is gross
* Gemtext doesn't have tables, text styling, images, and forms. It's too much of a significant price having to pay just to have a simpler document-focused version of the web
* You simply can't replace the web like this

Let's take a look at each in detail.

## Replacing the web

> [The web is] an organically grown mess of 25 years – but it will never be replaced by a dead-simple solution such as Gemini.
([source](https://lobste.rs/s/ivryqt/what_is_this_gemini_thing_anyway_why_am_i))

And in response to that as mieum had said:

> almost all of these posts are obsessed with the same strawman: some supposed audacity of Gemini to attempt replacing the web. It's hilarious that these authors (and commentors) have such poor reading comprehension.

As clearly as is written at the top on the Gemini homepage, people seem to forget that it neither wants nor tries to replace the web.

> Gemini is not "the fix" for the web's problems (or for gopher's for that matter). It is just a habitat, really; a way to inhabit a virtual space with other people. What *that* is and means will always be overlooked from the point of view that assumes Gemini *must* be all or nothing at all; that it *must* be a challenger to the throne.

In my opinion, Gemini is just a virtual space to put your content and read other people's work on. It's not supposed to be "oh, the web sucks, let's all just ditch the web switch over to this instead". There are still many wonderful and peaceful things on the web. And if you'd prefer scrolling through feeds with personalized ads, or if you prefer super-responsive, sleek, modern web pages that have cute animations, then maybe Gemini might seem dull and that Gemini is not for you. Ultimately, (in the words of mieum) it's a thriving ecosystem, and it doesn't need to be anything more than that.


## Lack of functionality in comparison to HTML

In regards to gemtext limitations, we have to keep in mind that Gemini is a protocol. Gemtext is a markup language. You can serve whatever you like on Gemini -- HTML, markdown, etc. And you can also view your HTML content over Gemini with a client that supports HTML. As far as I can tell, most features that gemtext lacks had been discussed in the mailing list before, all of which, I'm pretty sure, alternatives or workarounds were suggested. I think this comment by Alex summarises it well:

> Everyone wants something added to Gemini but disagrees what that something is. Personally, I think it should be in-line images and footnotes, but if Gemini became more complex, it would lose many of the traits that make it interesting. Gemini is a technology that invites us not to try and improve or optimize it, but to accept it as it is and work around its limitations – it is intentionally austere, and this is a feature, not a bug.

([source](https://lobste.rs/s/3nsvkk/gemini_is_useless#c_1zpxad))

For me, I'm fine with not having inline images, footnotes, or maybe even syntax highlighting in preformatted text. But as to tables, yes, that could make it look better, and easier to copy contents, but it would lose its simplicity and ease of developing new software around it. If gemtext was to support a similar type of table syntax as markdown, for example, the table would look extremely broken for clients that do not support it. Unless it is put in a preformatted block, though in which case that wouldn't solve the problem of horizontal scrolling in small screens.

In regards to inline links, sure, that could clear some clutter by removing the "[1]", but support for this could lead to escaping characters in the syntax, and then escaping the characters that escape the characters, which adds layer upon layer of complexities, again, losing its simplicity.

For me personally, if gemtext supported tables, inline links, and maybe "---" dividers, it *would* make my life a tiny bit easier when creating content, (though not necessarily when developing my own client). But it's not like you can't do *anything* with gemtext. You'd just have to get used to it. Gemini strictly separates the roles of content and presentation, the author provides the content and the client can control the presentation in whatever style it likes.

## Do we need a whole new protocol?

For me personally, I like fresh starts. So sure, a new protocol, new ways to think about the internet, and some getting used to is a great idea. It might be a pain for some to set up mirrors of their web content, but it's the experience and room to explore endless possibilities on a new medium that matters. Since you need new software, it's a perfect opportunity to learn a new language and get your own stuff out there. It's just the beginning, so there aren't many "rulers" in this space, as opposed to the web with popular browsers like chrome.

At the end of the day, the fact that I create and browse content in Geminispace every now and then does not mean I've decided to not use the web at all, nor does it mean that all of the good content is in Geminispace instead of the web. Like mozz said on Station:

> I'm not here because I hate the web, I'm here because I like Gemini.

([source](gemini://station.martinrue.com/mozz/d29f6cf900b04aef9e7a2332c2098f13))

You don't have to ditch the web to use Gemini. You get to choose what you write about, but you don't get to choose the color of your headers, or the font size of your body paragraphs. Go use the web if you want that.

---

## Full list of references:
* [Why Gemini is Not My Favorite Internet Protocol (Lobste.rs)](https://lobste.rs/s/vhlagb/why_gemini_is_not_my_favorite_internet)
* [Gemini is Useless (Lobste.rs)](https://lobste.rs/s/3nsvkk/gemini_is_useless)
* [Gemini is Useless (HN)](https://news.ycombinator.com/item?id=27490769)
* [bentsai.smol.pub/embracing-constraints](//bentsai.smol.pub/embracing-constraints)
* [mieum.smol.pub/for-the-love-of-gemini](//mieum.smol.pub/for-the-love-of-gemini)
* [What is this Gemini thing anyway, and why am I excited about it?  (Lobste.rs)](https://lobste.rs/s/ivryqt/what_is_this_gemini_thing_anyway_why_am_i)
* [mozz's message posted on Station (via Gemini to HTTP Proxy)](https://proxy.flounder.online/station.martinrue.com/mozz/d29f6cf900b04aef9e7a2332c2098f13)
* [Beyond Gemini? (In response to "Why Gemini is not my favourite internet protocol")](https://thomask.sdf.org/blog/2021/06/12/beyond-gemini.html)
