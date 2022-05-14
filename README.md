# ~hedy's site

This is my website and gemini capsule source code. Link is currently
hedy.tilde.cafe on both [web](https://hedy.tilde.cafe) and
[gemini](gemini://hedy.tilde.cafe).


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

- [ ] let gemini version also have a post page at /posts/index.gmi
- [ ] post-index.md and gmi for content put after the posts list
- [ ] rethink on the post slugs. currently `/posts/file-name-or-slug/` but I
  might put the date or something in there idk

- [ ] minify images and use WebP
