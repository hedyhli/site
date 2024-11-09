+++
title = "Writing Fonts"
description = "A little story on my favorite fonts for writing and reading."
date = "2024-11-09T12:18:55Z"

draft = false
outputs = ['html']

slug = "writing-fonts"
tags = []

highlight = false
font = "mono"

# [[syndications]]
# list =
# mastodon =
+++

In search of the perfect font for drafting and digital journalling.

## Inter

The story began when I was looking for Logseq themes. I chose [miA](https://github.com/playerofgames/logseq-mia-theme), a theme inspired by iA Writer and MacOS UI. It recommends IBM Plex Sans and iA Writer Quattro[^quattro-or-duo] as one of the fonts for text. For some reason, neither called out to me at the time. By serendipitous discovery I found and have come to adore the [Inter](https://rsms.me/inter/) font. I switched to that for Logseq as well as Emacs for the Emacs variable pitch font (such as in Org Mode).

[^quattro-or-duo]: It may have been Duo instead. Though it's one of them, for the miA sans variant.

Through unrelated rabbit-holes I rediscovered the beauty of Inter in Omnivore, a bookmarking service that offers an interface for reading saved articles. I chose the Inter font yet again, and thought that this was the most beautiful thing in the world. (Perhaps the pixel-perfect display of my reading device played a bigger role to this sentiment, but Inter sure looks really good.)

## iA Writer Quattro

A year or two later, I picked up Logseq again after a period of inactivity. Logseq had gone through many rounds of updates and the miA theme was sadly no longer fully compatible. I then went back and forth between rolling my own theme (minor customizations to the default with CSS) and making the fixes on top of miA. The primary font used for text caught my attention yet again. But this time, iA Writer Quattro[^more-about-ia-fonts] emerged as a new contender. Unfortunately, I quickly realized after switching to Quattro in a rush to perfect my Logseq experience, that ligatures (such as turning `-` followed by `>` into an arrow) was specific to Inter! 

[^more-about-ia-fonts]: If it interests you, it may be worth looking into other fonts iA Writer includes -- Mono, Duo, and Quattro in [this article about Duospace](https://ia.net/topics/in-search-of-the-perfect-writing-font) as well as [this other one](https://ia.net/topics/a-typographic-christmas) on the fonts.


## IBM Plex Sans and Mono

Looking more into the iA Writer fonts I discovered that they were based on top of IBM Plex fonts. I decided to switch back to Inter for the text font, but use IBM Plex Mono for code, hoping to retain the fuzzy feeling I get when I behold the Quattro by leveraging my frequent use of code blocks, but keep those pretty ligatures[^ligatures].

[^ligatures]: I might have some unpopular opinion on ligatures. Although I had been using Fira Code in my terminal since forever, which is a font known for its ligatures, I turned them off completely as it didn't feel right to me. In code, I want the font to reflect what I write and what the parser of the compiler eventually sees. Especially so when learning new languages as I need to acclimatize to new operators. Ligatures in code divorce the semantics of the operator from the symbols itself and they rarely make a piece of code easier to read for me. Ligatures in prose, though, they are cute and sensible because I would only ever want a `->` to actually represent an arrow.


It worked out well. In fact, I was so happy with IBM Plex Mono that I jumped ship by switching to IBM Plex Mono in my terminal (where I previously always used Fira Code)!

## So... the best writing font?

I have a blog which, admittedly, receives unbearably infrequent updates until only recently. Carrying my new-found passion of admiring amazing fonts for reading and writing, I decided to try crafting a writing experience that makes the process enjoyable. In other words, incentivizing myself to write more through the lure of seeing text in a beautiful font appear before my caret. I started off with IBM Plex Sans[^writing-experience-other-than-font].

[^writing-experience-other-than-font]: Apart from the font, there were some other design choices made such as a clear and minimal interface, a pleasant yet good contrast color scheme, and a system that simply "works" without having to distract me with wanting fixing all the little broken things.

It worked quite well, until I started to write more frequently. Something just felt off. I missed writing prose in the terminal where my caret was block-shaped and it felt as though I was whispering into the void. Instead I was making an important speech in front of the entire world ad-hoc. What I see as I wrote was what my reader will see. It was as though I have to get everything perfect the first time or any blunders will look stupid under the beautiful variable-pitch font.

So I decided to get a free trial of iA Writer. Turns out, it uses a mostly monospace-looking font by default. How can it be? We're not writing code! Oh, right, this came from typewriters which essentially *had* to produce fixed-width text. But surely there are other reasons apart from... legacy or even nostalgia? I decided to give [iA Writer's article on Duospace](http://ia.net/topics/in-search-of-the-perfect-writing-font/) a proper read. A little shocked to find that "in search of the perfect writing font" -- a decent subtitle for the post I am currently writing right there in the title -- articulated my experience quite precisely:

> In contrast to proportional fonts that communicate “this is almost done” monospace fonts suggest “this text is work in progress.” It is the more honest typographic choice for a text that is not ready to publish.
> 
> [...]
> 
> Proportional fonts save space. They suggest that you “hurry up and fill the page.” Monospaced fonts, on the other hand, feel more productive. Every typed letter translates into a homogenous visual progress in writing. It is both more relaxing to write at a slower pace and more satisfying as the progress is more tangible.

I've been using iA Writer Duo for drafting and digital journal ever since.

On my blog, as of writing, I use Inter for the post body, IBM Plex Sans for headings and IBM Plex Mono for code. On posts such as this one which I deem to require a more accurate representation of my writing environment, I use iA Writer Duo.


## Addendum: Reading fonts

Here are some of my favorite fonts suited for reading:
- [Inter](https://rsms.me/inter/) & [IBM Plex Sans](https://www.ibm.com/plex/), as mentioned in the post
- [iA Writer Duo & Quattro](https://github.com/iaolo/iA-Fonts) (the Duo might be a good choice for use in websites that goes for the "monospace"/retro vibe while remaining fairly easy to read)
- [Fira Sans](https://en.wikipedia.org/wiki/Fira_(typeface))
- [Atkinson Hyperlegible](https://en.wikipedia.org/wiki/Atkinson_Hyperlegible)
- Basier
- [Geist](https://vercel.com/font)
- Epilogue (found on https://lume.land/)
- Aptos, the font Microsoft recently started using -- to me if feels to be a blend between Inter and IBM Plex Sans, but that isn't to say that it is superior to either.
