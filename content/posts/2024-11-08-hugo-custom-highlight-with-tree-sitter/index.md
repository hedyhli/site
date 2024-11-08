+++
title = "Custom syntax highlighting with Hugo and Tree-sitter"
description = "How I made a Hugo site work with Tree-sitter for custom syntax highlighting."
tags = ['howto', 'hugo']
highlight = true
draft = false

date = "2024-11-08T10:14:45Z"
outputs = ['html']
# Filename after the date
slug = "hugo-custom-highlight-with-tree-sitter"
+++

I recently helped migrate the homepage of [Cognate](https://cognate-lang.github.io), a stack-based, lisp- and ML-inspired programming language, to Hugo. Here's how I added Cognate language syntax highlighting for our Hugo site.

## Overview

We needed syntax highlighting for code blocks in Cognate, but Hugo comes with Chroma (its syntax highlighter) baked in, and does not allow any form of customization through Hugo when it comes to supporting additional languages:

- [An open GitHub issue on this topic](https://github.com/gohugoio/hugo/issues/11496) with "Unscheduled" milestone as of writing
- [No arbitrary code execution in Hugo templates](https://github.com/gohugoio/hugo/issues/796)
- [No support for custom functions as Go plugins yet](https://github.com/gohugoio/hugo/pull/11085), though WASM is [planned](https://github.com/gohugoio/hugo/issues/12737), it seems a little overkill for our purposes

Which means our only choice was to either pre-process markdown code blocks and let Hugo's Goldmark[^goldmark] render `<pre>` blocks already highlighted in markdown content files, or post-process the HTML after Goldmark is done with them.

[^goldmark]: Hugo uses Goldmark for markdown processing.

My initial instinct was to go with the former, since finding markdown code-blocks was simply a matter of `/^```cognate/ { ... }` in awk. In hindsight, this was not the simpler solution, because we'll have to keep a copy of the entire `content/` directory structure for Hugo to consume, whereas processing HTML can be done per-file as Hugo is already done with it.

In reality, Goldmark ended up attempting to parse the HTML within `<pre>` tags as markdown (despite setting `unsafe = true` in the config to allow HTML in markdown). Hugo's [passthrough hooks](https://gohugo.io/render-hooks/passthrough/) is supposed to help with this by allowing you to configure delimiters, between which Goldmark will preserve the markdown (in our case, HTML), raw. Unfortunately this did not work for some reason.

So we opted for post-processing the HTML, and the process we ended up with looks like this:

1. Use a [code block render hook](https://gohugo.io/render-hooks/code-blocks/) to mark Cognate code blocks (e.g., `language-cognate` class, or a `<!--cognate-->`), and run Hugo as usual
2. Run a script on each output HTML file, detect Cognate code blocks (marked by Step 1)
3. Run our custom syntax highlighter, and update the HTML file

## Step 1: Render hook

The purpose of this step is for our script later on to determine which code blocks are Cognate. If you are using Chroma for other languages, you can simply look for `<code class="language-[LANGUAGE]>"` which is added by Chroma.

In our case, we'll use a [Hugo render hook](https://gohugo.io/render-hooks/code-blocks/) to mark the language ourselves.

The template at `layouts/_default/_markup/render-codeblock-cognate.html` will executed for each Cognate code block when Hugo renders each markdown file:

```html
{{ printf "<!--cognate-->" | safeHTML }}<pre><code>
{{ .Inner | safeHTML }}
</code></pre>
```

This makes the HTML output for code blocks deterministic, so we can easily look for the code we want to highlight later on.

## Step 2: Post-process HTML

In this step we use a script to update each output HTML file produced by Hugo.

Any programming language will do. Here I have opted for a simple Makefile with awk:

```make
AWK=awk
HUGO=hugo

.PHONY: build
build:
	# ... rest of your build process
	$(HUGO)
	# ... rest of your build process
	make $(shell find public -type f -name "*.html")

public/%.html: .FORCE
	@mv $@ tmp.html
	$(AWK) -v outfile=$@ -f scripts/process-code-blocks.awk tmp.html
	@rm tmp.html

.PHONY: .FORCE
.FORCE:
```

In a single `make`/`make build`, it builds the site with Hugo, then runs the awk script at `scripts/process-code-blocks.awk` which goes through each HTML file and runs our custom syntax highlighter:

```awk
BEGIN {
  inCode = 0;
  code = "";  # The raw cognate code to highlight
  highlightCmd = "$PWD" "/scripts/highlight";
}

inCode == 0 && $0 !~ /^<!--cognate/ {
  # Print HTML other than <pre></pre> lines as-is
  print $0 >> outfile;
}

$0 == "</code></pre>" {
  # End of a code block
  if (inCode == 1) {
    printf "%s", "<pre><code>" >> outfile;
    print code | (highlightCmd " >> " outfile);
    close(highlightCmd " >> " outfile);
    printf "%s", "</code></pre>" >> outfile;

    inCode = 0;
    code = "";
  }
}

inCode == 1 {
  # Within code block
  code = code $0 "\n";
}

/^<!--cognate/ {
  # Start of code block
  inCode = 1;
}
```

In the script, we look for `<!--cognate-->`, extract the code block, run it through `highlightCmd`, and save it in the output file. All other lines of HTML are copied as-is.

## Step 3: The `highlight` script

If the language you want to use is not supported by Chroma, you might have some luck with [Highlight.js](https://highlightjs.org) or [Pygments](https://pygments.org). Both allow you to implement lexers in additional languages with regex[^regex-lexers-docs].

[^regex-lexers-docs]: See [Language Definition Guide for Highlight.js](https://highlightjs.readthedocs.io/en/stable/language-guide.html) and ["Write your own lexer from Pygments' docs](https://pygments.org/docs/lexerdevelopment/).

For Cognate, we decided to go with [Tree-sitter](https://tree-sitter.github.io) since we already have a [Tree-sitter grammar](https://github.com/hedyhli/tree-sitter-cognate) for implementing editor support. Luckily, Tree-sitter CLI supports outputting highlights in HTML. So a single command will do for running syntax highlighting.

In `script/highlight` (`highlightCmd`), we'll call `tree-sitter highlight` with `--html`/`-H` flag and specify the path to `highlights.scm` for highlight captures[^highlights.scm]. It outputs a full HTML page together with line numbers implemented using a HTML table, but we only need the `<pre>`; `sed(1)` comes in handy (courtesy of [@StavromulaBeta](https://github.com/StavromulaBeta)):

[^highlights.scm]: This file tells Tree-sitter which parts of the code to highlight, and what highlight group should apply. Captures are done by pattern matching on the syntax tree with lisp syntax.
 
```sed
s/.*<table>\n\(.*\)\n<\/table>.*/\1/
s/<tr><td class=line-number>[0-9]\+<\/td><td class=line>\([^\n]*\)\n<\/td><\/tr>/\1/g
```

This strips out everything we don't want from Tree-sitter's HTML output.

Putting it together, `scripts/highlight` looks like this:

```sh
tree-sitter highlight \
  --query-paths $PWD/highlights.scm \
  --config-path tree-sitter.json \
  --scope source.cog -H /dev/stdin | sed -z '
s/.*<table>\n\(.*\)\n<\/table>.*/\1/
s/<tr><td class=line-number>[0-9]\+<\/td><td class=line>\([^\n]*\)\n<\/td><\/tr>/\1/g'
```

Two points of note:
1. `--scope` is needed here to have stdin be recognized as Cognate code -- "source.cog" is configured in the `package.json` of Tree-sitter grammar repo.
2. `--config-path tree-sitter.json` is a config file for Tree-sitter. Conveniently, we can use this file to configure the color scheme for syntax highlighting.

Pipe in some Cognate code from stdin, and out comes rendered HTML with syntax highlighting. This script is run on each Cognate code block found in each HTML file produced by Hugo.

## Conclusion

That's it! This is the entire build process for [Cognate's project website](https://cognate-lang.github.io/) from start to finish with custom syntax highlighting using Tree-sitter.

Perhaps parsing Tree-sitter CLI's output was unnecessary and using a simple regex-based syntax highlighting, or even a simple script with a Tree-sitter library in a supported programming language will make less overhead. It might also have been easier if Hugo's passthrough render hooks worked they way I thought it would.

But well, the process I've illustrated above works, and it will continue to work to serve our purposes unless Tree-sitter or Hugo make drastic changes to its output format in future releases.

The source code for Cognate's website is available on [GitHub](https://github.com/cognate-lang/cognate-lang.github.io/).

## See also

- [Highlighting Code with Shiki in Hugo](https://jo3-l.dev/posts/shiki-hugo/) -- An arguably more reliable approach to post-processing HTML by using a proper HTML parser, and Shiki for highlighting. Uses JavaScript rather than Makefiles, Awk, and Sed.
- [Hugo render hooks](https://gohugo.io/categories/render-hooks/)
- [Hugo passthrough hooks](https://gohugo.io/render-hooks/passthrough/)
