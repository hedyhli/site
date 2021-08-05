---
title: "Setting up syntax highlighting for Hugo"
highlight: true
date: 2021-08-05
draft: true
outputs:
  - html
  - gemtext
slug: hugo-syntax-highlighting
tags:
  - setup
description: "How I've set up syntax highlighting for hugo, powered by chroma."

---

Hugo uses [chroma](https://github.com/alecthomas/chroma) as its syntax
highlighter, and it's mostly compatible with pygments. All you basically need
for having your code highlighted is to let chroma put the syntax classes
in the generated HTML, for the correct language, and then make sure you have
corresponding CSS for those classes.

## Config

In your configuration file, `config.toml` for example, add these settings so you
can have your code highlighted and have it recognize Fenced Code Blocks
for markdown:

```toml
pygmentsUseClasses = true
pygmentsCodeFences = true
```

## CSS

You can have your own CSS styles, but there are *a lot* of classes, so if you're just
starting out, and want to have it working quickly, you can choose an existing style.

Browse the [gallery](https://xyproto.github.io/splash/docs/) of available styles and use that style name to save the CSS file
into your `assets` directory:

```sh
mkdir -P assets/syntax
hugo gen chromastyles --style=STYLE > assets/syntax/main.css
```

If you'd like to use different styles for dark mode and light mode (like me), then
you can change "main.css" to "light.css", and save the dark mode style to "dark.css".
It doesn't matter where you put the file, but just remember to use that file name
with referencing it later.

You don't have to put it under the directory "syntax" too, if you don't want to.

## Apply the styles

In your `<head>` tag, where ever you have it in your `layouts/` you have to link to
your css file that you've just created. There are several ways you can do so. One
use a `<link>` tag and link to the URL of your CSS file, and two is to directly put
the content of your file into a `<style>` tag. Here's how you can do the second method.

## Extras

Not all of your site's pages need the syntax highlighting styles. If you'd like to have
the CSS there only for pages that need them, you can have a page parameter named "highlight"
which can be set to false by default. And in the page's frontmatter where you want
syntax highlighting, set it to true. Then change your `<head>`
