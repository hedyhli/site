# ~hedy's site

My [website](https://home.hedy.dev/) and [gemini capsule](gemini://gmi.hedy.dev/).

## philosophy

### architecture

- remain a static site, without *any* javascript unless *absolutely necessary*
  (ie, if the chosen solution (say, with SSR or JS) is the *best* option with
  minimal trade-offs, adopting principles of [Digital
  Minimalism](https://calnewport.com/on-digital-minimalism/), also see [use boring
  technology](https://boringtechnology.club)).
- serving of content should be performant, there is no application logic or
  related bottlenecks.
- use minimal and maintainable CSS and HTML templates.

### design

- no user-tracking or analytics whatsoever, for both WWW and gemini, unless it's
  minimal and privacy-respecting
- I might not be able to adhere to the strictest accessibility standards, but
  the WWW site should designed with accessibility in mind -- such as avoiding
  low-contrast and small text, or abusing element semantics
  - https://pinkvampyr.leprd.space/accessiblenet/guidelines.php -- following most, if not all
  - https://seirdy.one/meta/site-design/ -- some to most
- it should support open standards, screen readers, and reader mode to the best
  balance between aesthetics, maintability and compliance.
- for WWW: design to look *decent* (usable) in *most* TUI browsers (that I know
  of, and can test on)
- for gemini: stick to providing content and avoid using hacks or text
  formatting outside of preformatted blocks to design with both constant width
  clients and variable width clients in mind.
- good support for common screen sizes
- for WWW: minimal custom color scheme, especially for dark mode. enough to
  provide semantics and a light touch of "branding", though.
- all this does not in anyway the lack of personality or the 'personal website'
  quirky feel of it all! should definitely be less afraid of introducing changes
  like that in addition to the blinking underscore on the front page.

## features

It has a blog and a few pages. The blog has mostly the same post for web/gemini.

WWW provides both an atom feed and an RSS feed whilst gemini provides a standard
gemini atom feed.

Tags, last modification dates and changelog links are implemented. but may not
currently provide public-facing direct links per-post.

Comments currently run through email and and a mailing list, with links to
external discussions (if any) in each post.

A dynamic or pre-fetched comment system is *not currently planned* for both WWW
and gemini.

Webmentions and pingbacks and supported using hosted -aaS links though I plan to
switch to self-hosted solutions in the future, such as a lightweight CGI
implementation.

That's about it! Nothing fancy. The CSS is *pretty* minimal, but not a brutalist
design. It has a few custom colors, a sans-serif font stack, and some styling in
the footer and nav. Everything else is partially based on top of [simple
css](https://simplecss.org) and sometimes [seirdy's site](https://seirdy.one).

## requirements

### build
- **hugo** - generate files - `hugo v0.133.1`

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

#### Bookmarks

```sh
mkdir assets/data
cp .envrc.example .envrc
# Edit .envrc
direnv allow
```

### deploy
- **hut** - publishes gemini files to srht.site

### lint
- **pnpm** - install dev dependencies in `package.json`
- **ruby** (`>= 2.7` for `htmlproofer`)

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
- [x] lint
- [x] provide atom feed for www
- [x] show post description in list
- [x] proper reply via email link
- [ ] better a11y
- [ ] minify images and use WebP

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

### webmentions

```sh
curl 'https://webmention.io/api/mentions?target={permalink of page}' | jq '.links' > new-entries.json
jq -n '[ inputs ] | add' assets/data/{slug}/webmentions.json new-entries.json > merged.json
```
