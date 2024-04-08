# ~hedy's site

This is my website and gemini capsule source code. Link is currently
hedy.tilde.cafe on both [web](https://home.hedy.dev) and
[gemini](gemini://home.hedy.dev).

As of now, static site hosting is provided by srht.site.


It has a blog and a few pages. The blog has mostly the same post for web/gemini
and the web version has an RSS feed and the gemini version has an atom feed.
I also have tags, last-update, and changelog link for each post. As to comments
it's currently via email, though I plan to setup CGI-based like/comment system
for gemini. Webmentions are planned too, I have linked the pingback etc links
in the `<head>` but I don't have them setup and working yet. I also want to
make this a lightweight CGI-based solution.

That's about it! Nothing fancy. The CSS is *pretty* minimal, but not brutalist
design. It has a few custom colors, a sans-serif font stack, and some styling in
the footer and nav. Everything else is partially based on top of [simple
css](https://simplecss.org) and sometimes [seirdy's site](https://seirdy.one).

## todo

- [x] let gemini version also have a post page at /posts/index.gmi
- [ ] minify images and use WebP
- [x] provide atom feed for www
- [x] show post description in list
- [ ] proper reply via email link

## writing

```sh
bin/post
```

## deploy

Also see [gemcgi](../gemcgi)

```sh
make all deploy
```

### twtxt

Hardcodes destination host and gemini directory.

```sh
bin/twt
```
