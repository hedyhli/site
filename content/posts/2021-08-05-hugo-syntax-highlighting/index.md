+++
date = '2021-08-22'
description = "How I've set up syntax highlighting for my website with dark mode support."
draft = false
highlight = true
outputs = ['html', 'gemtext']
slug = 'hugo-syntax-highlighting'
tags = ['howto', 'hugo']
title = 'Setting up syntax highlighting for Hugo'
+++

Hugo uses [chroma](https://github.com/alecthomas/chroma) as its syntax
highlighter. All you basically need for having your code highlighted is to let
chroma put the syntax classes in the generated HTML, for the correct language,
and then make sure you have corresponding CSS for those classes.

Let's start by enabling syntax highlighting in your configuration file.

In your configuration file, `config.toml` for example, add these settings so
you can have your code highlighted and have it recognize Fenced Code Blocks for
markdown:

```toml
pygmentsUseClasses = true
pygmentsCodeFences = true
```

Next you have to include the styles. There are two ways to go about this, one
is to choose a style from the list of available styles (more on that below),
and the second method is to use your own syntax theme.

You can have your own CSS styles, but there are *a lot* of classes, so if
you're just starting out and want to have it working quickly, you should choose
an existing style.

Browse the [gallery](https://xyproto.github.io/splash/docs/) of available
styles and use that style name to save the CSS file into your `assets`
directory:

```sh
mkdir -p assets/syntax
hugo gen chromastyles --style=friendly > assets/syntax/main.css
```

If you'd like to use different styles for dark mode and light mode (like me),
then you can change "main.css" to "light.css", and save the dark mode style to
"dark.css".  It doesn't matter where you put the file, but just remember to use
that file name with referencing it later.

You don't have to put it under the directory "syntax" too, if you don't want
to.

## Apply the styles

You have to link to your CSS file that you've just created in your `<head>`.
There are several ways you can do so.

1. Use a `<link>` tag and link to the URL of your CSS file, or
2. directly put the content of your file into a `<style>` tag.

Here's how you can do the second method.

```tmpl
{{- $syntaxCSS := resources.Get "syntax/main.css" | minify -}}
<style>
	{{ $syntaxCSS.Content | safeCSS }}
</style>
```

Assuming your CSS file is at `assets/syntax/main.css`.

All set for the styling part! Now you can write some content and try it out.

Remember to include the file type when putting code in markdown.

````md
This is not code

```sh
# and this is some sh code
echo 'hi!'
```
````

## Dark mode and light mode

You can have different styles of syntax highlighting for dark mode and light
mode.

First you have to export or save your CSS for dark mode and light mode in
separate files .  Then, change the part in your `<head>` where you've included
the styles:

```tmpl
{{- $syntaxlight := resources.Get "syntax/light.css" | minify -}}
{{- $syntaxdark := resources.Get "syntax/dark.css" | minify  -}}
<style>
	{{ $syntaxlight.Content | safeCSS }}
	@media (prefers-color-scheme: dark) {
		{{ $syntaxdark.Content | safeCSS }}
	}
</style>
```

This assumes you have your light styles and dark mode styles stored in
`assets/syntax/light.css` and `assets/syntax/dark.css` respectively.

Instead of doing the above, you could have just put both in a single file and
include the `@media (prefers-color-scheme: dark)` line in there directly, and
this won't require you to change your `<head>` at all. And of course you could
have just used CSS variables and store the theme's colors into different
variables, use `var(--variable-name)` for each class in the styles, and finally
have a different set up variable values for `@media (prefers-color-scheme:
dark) {}`.  But using the method of separating dark and light styles has the
advantage of changing the themes for light or dark mode in the future with the
`chroma` command and pipe it to the file directly, without having to edit the
CSS file by hand.

## Applying syntax highlight CSS file only when it's needed

Fetching syntax highlighting theme and putting it in your `<head>` means that
every single page would have the syntax highlighting CSS code in the page,
regardless of whether the page actually uses it. If you'd like to only include
the syntax CSS files for pages that needs syntax highlighting, you can use a
page parameter named something like `highlight`.

Here's how it would work.

* Set a `highlight` param in your global config file that is set to false by default
* For each post or page in your `content/` that needs syntax highlighting, include `highlight: true`
in the frontmatter (assuming you're using YAML).
* In `<head>`, check whether the page's `highlight` param is set to true, and only if it's true, the
CSS resource is loaded.

In your `<head>`, include this before fetching the CSS resource, and put
`{{ end }}` after `</style>`:

```tmpl
{{- if .Params.highlight -}}
<!--Put the code that fetches your syntax highlight CSS here-->
{{- end -}}
```

This tells hugo to only load the resource and put the CSS in `<style>` if the page parameter
`highlight` is set to true.

## Read more

- [Configuration options for syntax highlighting](https://gohugo.io/getting-started/configuration-markup#highlight)
- [Highlighting specific lines in code snippets](https://gohugo.io/content-management/syntax-highlighting/#example-highlight-shortcode)
- [The built-in `highlight` shortcode for manual highlighting](https://gohugo.io/content-management/shortcodes/#highlight)
