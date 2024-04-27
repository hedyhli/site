# ~hedy's site

This is my website and gemini capsule source code. Link is currently
home.hedy.dev on both [web](https://home.hedy.dev) and
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

## requirements

### build
- **hugo** - generate files

- **rsync** - separate HTML & gemini files into dedicated destinations
  perhaps I'll just switch to plain copying in the future. This was a relic of
  the old deployment system where I kept some extra files (such as CGI scripts)
  in the destination which should not be deleted.

  what this means is that I'll have to do `rm -rf DEST/*` periodically to clean
  up old files

- **python3** - postprocessing on the gemini files

- **prettier** - format HTML files
  this requires my template HTMl files not rely on newline for spacing.

  to test, simply remove the prettier command from Makefile, run `make gen &&
  mkdir public2 && cp -r public public2` and run prettier on `public2`, make
  sure everything in `public2` looks the same as `public`.

### deploy
- **hut** - publishes HTML/gemini files to srht.site

### lint
- `pnpm` - install dev dependencies in `package.json`
- `ruby >= 2.7` - for `htmlproofer`

## hardcoded values

### resources

In WWW, posts' resources are stored under the same directory as the post:
- `/posts/my-slug/index.html` (the post itself)
- `/posts/my-slug/resource-1.png`
- `/posts/my-slug/resource-2.svg`

In gemini, posts' resources are stored together under a separate folder:
- `/posts/my-slug.gmi` (the post itself)
- `/posts/assets/my-slug_resource-1.png`
- `/posts/assets/my-slug_resource-2.png`

These files might need to be changed to customize this:
- `bin/gemini-clean.py`
- `layouts/shortcodes/get-resource-link.*`

## todo

- [x] let gemini version also have a post page at /posts/index.gmi
- [ ] minify images and use WebP
- [x] lint
- [ ] better a11y
- [x] provide atom feed for www
- [x] show post description in list
- [x] proper reply via email link

## Workflows

### posts

```sh
bin/post
```

resources should be put in the same directory as the post. Link to them within
markdown ad gemini files using the `get-resource-link.{gmi|html}` shortcode
which returns the relative permalink of the file. (see [resources](#resources).)

### deploy

```sh
make all deploy
```
