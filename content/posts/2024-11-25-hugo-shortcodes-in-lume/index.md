+++
title = "Hugo shortcodes in Lume"
description = "I needed HTML components in Lume similar to Hugo shortcodes and tried MDX. Here's how I implemented Hugo shortcodes in Lume after facing issues with MDX."
date = "2024-11-25T07:12:24Z"

draft = false
outputs = ['html']

slug = "hugo-shortcodes-in-lume"
tags = ['howto', 'hugo', 'lume']

highlight = true
# font = "mono"

# [[syndications]]
# list =
# mastodon =
+++

Recently, I've been looking at [Lume](https://lume.land/), a new-ish static-site generator that runs on [Deno](https://deno.land/) as a possible replacement for Hugo on my site.

I decided to give it a try when starting a new project, the static site for [Meta Ring](https://meta-ring.hedy.dev/). The many things Lume does well that made me consider the switch is beyond the scope of the article. Instead, let's talk about one thing I miss from Hugo: shortcodes.

<div class="callout note">

  If you're looking for the TL;DR solution, skip to the [conclusion](#conclusion).
</div>


The homepage for my webring required a list of webring members, which is defined in a data file as JSON. It's trivial to use a template engine to parse the JSON and display the HTML, but I needed a way to specify where I want to insert that member list in my `index.md`. This would be easy had I used Hugo, because Hugo shortcodes lets me do exactly that.

For my Lume project, I explored some alternatives such as MDX, but finally arrived at a custom solution. First, I'll explain how Hugo shortcodes work.

## Hugo shortcodes

[Shortcodes](https://gohugo.io/content-management/shortcodes/) in Hugo are fairly similar to components in [MDX](https://mdxjs.com/). MDX lets you write your usual JSX/TSX components and embed them directly within markdown for content pages and blog posts. This is extremely useful in CMSes and static-site generators when you need to insert a custom component of any kind directly within markdown content[^components].

[^components]: Usually, this just means anything you might want to use twice that needs to be HTML inserted within markdown.

In Hugo, shortcodes are defined using Go HTML templates. When executed, they receive certain metadata such as the page being rendered and the content included within the tags.

### Example

Here's how I would implement the webring member listing in Hugo.

Create a shortcode template at `layouts/shortcodes/members.html`:

```html
{{/* ...code to fetch the JSON */}}
<ul>
{{ range $members }}
  <li>
    <p><a href="{{ .url }}">{{ .name }}</a></p>
    <p><a href="{{ .colophon }}">{{ .colophon }}</a></p>
  </li>
{{ end }}
</ul>
```

Use the shortcode in markdown:

```md
Some introductory material

# Members

Check out our awesome members!

{{%/* members */%}}

---

Some content that follows.
```


## MDX

To implement components similar to Hugo shortcodes in my Lume site, I first looked at MDX since it was included as an official plugin.

The limitation became apparent pretty quickly. You have to define your components with JSX or TSX. If you wish to use HTML templates to define components, using them will require an ugly workaround:

```jsx
<div dangerouslySetInnerHTML={
  { __html: comp.members() }
} />
```

Furthermore, the MDX content format also comes with [its own limitations](https://github.com/micromark/mdx-state-machine#72-deviations-from-markdown) on top of both markdown and JSX, such as no support for autolinks (`<url>`) and no HTML/JSX comments.

And what if I decided to just roll with it and define my components in JSX/TSX? That'll mean adding `npm:react` (or preact) on top of my stack of dependencies!

Which means, I'll need something else. Preferably, something that lets me define components with HTML templates...[^html-templates]

[^html-templates]: I did not use Web Components, because I needed the components to be resolved during the build process by the static site generator, and have support for older browsers, TUI browsers, and screen readers.


## Without MDX

Here's what we currently have:

- Lume uses [markdown-it](https://github.com/markdown-it/markdown-it) by default for creating pages in markdown. It supports extension with custom plugins that change how markdown is rendered. It also supports including HTML directly in the markdown, but text within HTML tags will still be parsed as markdown, similar to GitHub Flavored Markdown.

- Lume pages have a `templateEngine` field. This is a list that decides how your raw `.md` files will get transformed into `.html`[^templateEngine]. By default, this will only be markdown-it. I can add `vento` (or another HTML templating engine) to the list, so that markdown pages can be preprocessed using a templating engine before being fed into markdown-it. This will let us use `{{ templating tags }}` within markdown to include our components.

- Lume has its own "[generic Lume components](https://lume.land/docs/core/components/)". You can define HTML templates, or even JSX/TSX components in the `_components/` directory. Then, in page templates, use components with `{{ comp.MyComponent({ ...options }) }}`. The relevant component is executed and the tag replaced with the output HTML as part of the static site build process.

[^templateEngine]: Note that the name `templateEngine` is misleading. In Lume, you can create page with Markdown, with HTML templates, with TypeScript, with JSX, or even anything else supported by plugins. Creating HTML pages with Markdown, in Lume, is essentially running a markdown renderer (in this case markdown-it), on your `.md` files as a "template engine".


All this is enough to have a bare-bones implementation of Hugo shortcodes within Lume -- but there's a catch. Let me explain how to make it mostly works and we'll get to the catch later.

## A half-baked solution

We'll define the member list component in `_components/members.html` as a Lume component with [Vento](https://vento.js.org/) templating:

```html
<ul>
{{ for item of members }}
  <li>
    <p><strong><a href="{{ item.url }}">{{ item.name }}</a></strong></p>
    <p><a href="{{ item.colophon }}">{{ item.colophon }}</a></p>
  </li>
{{ /for }}
</ul>
```

<div class="callout note">

The `members` variable contains the unmarshalled JSON list. This works by putting the member list in `_data/members.json` as Lume's [shared data](https://lume.land/docs/creating-pages/shared-data/).
</div>

Next, in the frontmatter of `_index.md`, specify that we want to use Vento (our templating engine) to preprocess the markdown before passing it to markdown-it:

```yml
title: "Meta Ring"
templateEngine: [vento, md]
```

And finally, in the relevant location in `index.md`, use the component:

```md
## Members

{{ comp.members() }}
```

This works:

```html
<h2 id="members" tabindex="-1"><a href="#members" aria-hidden="true">##</a> Members</h2>
<ul>
  <li>
    <p><strong><a href="https://home.hedy.dev/">~hedy</a></strong></p>
    <p><a href="https://home.hedy.dev/meta/">https://home.hedy.dev/meta/</a></p>
  </li>
  <!-- ... -->
</ul>
```

So where's the catch?

Review the entire process:
1. `index.md` is rendered with Vento,
2. Vento sees a `comp.members()` call,
3. Vento renders `_components/members.html`,
4. The call is replaced with the resulting HTML,
5. Contents of `index.md` with `comp.members()` replaced with HTML `<ul> ... </ul>` is passed to markdown-it.

The issue here is that markdown-it continues to attempt to parse markdown even within HTML tags. But in Hugo, HTML shortcodes are strictly preserved as HTML, as-is.

If the members component were defined much less succinctly, such as including an extra newline somewhere, or if any of the `item.*` data we're inserting contains newlines with markdown, these will get rendered by markdown-it.

For example:

```html
<ul>
{{ for item of members }}
  <li><!-- look, a newline! -->

    <p><strong><a href="{{ item.url }}">{{ item.name }}</a></strong></p>
    <p><a href="{{ item.colophon }}">{{ item.colophon }}</a></p>
  </li>
{{ /for }}
</ul>
```

This produces:

```html
<ul>
  <li><!-- look, a newline! -->
<p></p><p><strong><a href="https://home.hedy.dev/">~hedy</a></strong></p>
<p><a href="https://home.hedy.dev/meta/">https://home.hedy.dev/meta/</a></p><p></p>
  </li>
  <!-- ... -->
</ul>
```

Which means we need a way to make markdown-it ignore whatever the output of the components we use, similar to "[passthrough hooks](https://gohugo.io/render-hooks/passthrough/)" in Goldmark for Hugo. For instance, have whatever that is between delimiters `:::` be rendered as-is, like fenced code blocks[^need-passthrough].

[^need-passthrough]: It may seem like this is a rather involved workaround, but it so happened that I needed a passthrough plugin like this in another part of the site.

## The final solution

Unfortunately, I couldn't find any existing passthrough plugins for markdown-it, so I rolled my own, based on the [markdown-it-container](https://github.com/markdown-it/markdown-it-container) plugin and the built-in fenced code block rule.

I've included it along with the code for the Meta Ring site in a [`passthrough.mjs`](https://github.com/hedyhli/meta-ring/blob/main/passthrough.mjs) file, and used it as a plugin in my Lume config:

```ts
import passthrough from "./passthrough.mjs";

site.hooks.addMarkdownItPlugin(passthrough, {});
```

Update the component template to use these delimiters:

```html
:::
<ul>
{{ for item of members }}
  <li><!-- look, a newline! -->

    <p><strong><a href="{{ item.url }}">{{ item.name }}</a></strong></p>
    <p><a href="{{ item.colophon }}">{{ item.colophon }}</a></p>
  </li>
{{ /for }}
</ul>
:::
```

And that's it! Regardless of the format of HTML we have in the component, it will be rendered as-is by markdown-it:

```html
<h2 id="members" tabindex="-1"><a href="#members" aria-hidden="true">##</a> Members</h2>
<ul>

  <li><!-- look, a newline! -->

    <p><strong><a href="https://home.hedy.dev/">~hedy</a></strong></p>
    <p><a href="https://home.hedy.dev/meta/">https://home.hedy.dev/meta/</a></p>
  </li>
  <!-- ... -->
</ul>
```


## Conclusion

There isn't yet an existing plugin for Lume that provides something similar to Hugo shortcodes, but it wasn't hard for me to implement it myself.

Here's how it works, in review:

- Define components in any templating engine format, in `_components/`. Include delimiters, or a `markdown="no"` attribute (specific to your markdown processor) to ensure the HTML for components are not processed as markdown. For markdown-it, I've implemented this functionality using [a custom plugin](#the-final-solution).
- Use your templating engine to pre-process markdown pages by specifying the list `templateEngine` in the frontmatter. For instance, `templateEngine: [vento, md]`.
- Include the component using the correct tags for your templating engine in markdown pages, such as `{{ comp.MyComponent() }}` in Vento, or `<%= comp.MyComponent() %>` in Eta.

And this will get you as close to Hugo shortcodes as I am aware of.

To escape tag delimiters for your templating engine in markdown, you'll have to either avoiding setting `templateEngine` on pages that do not need components, or use an escape tag. For example, `{{ echo }}{{ comp.example() }}{{/ echo }}` in Vento produces `{{ comp.example() }}`.

The source code for [Meta Ring](https://meta-ring.hedy.dev/) is available on
[GitHub](https://github.com/hedyhli/meta-ring).
