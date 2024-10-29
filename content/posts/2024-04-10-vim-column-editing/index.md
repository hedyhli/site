+++
date = '2024-04-10T05:22:46Z'
description = 'The visual block mode in Vim/Neovim is quite powerful. You can use it for "column" editing and vertically pasting blocks of text similar to paste(1).'
draft = false

hasFootnotes = true

outputs = ['html', 'gemtext']
slug = 'vim-column-editing'
tags = ['howto', 'terminal']
title = 'Vim visual block mode for column editing'

publicReplyTo = "mailto:~hedy/posts@lists.sr.ht?cc=hedy%20%3Chedy.dev%40protonmail.com%3E&in-reply-to=%3Cn7UVukOUgCClct4d56HGVviI9Ig0QFF1dp0XIjC1EHZkOq9kBq4oHhA_CpVUa1LKxD73wJAZn4kUaTBoIQtENvNDF6RiSUsMfbN8fT4y2fI%3D%40protonmail.com%3E&subject=Re%3A%20Vim%20visual%20block%20mode%20for%20column%20editing"
+++

The visual block mode in Vim lets you edit text simultaneously across adjacent
lines, similar to the "Alt-drag" feature in modern editors, but there's more you
can do with it.

One of the basic formatting style that can be done to plain text content would
be putting blocks of lines into columns, i.e., from this:

```text
List title 1
- Item 1
- Item 2
- Item 3

List title 2
- Item 1
- Item 2
- Item 3
```

To this:

```text
List title 1  List title 2
- Item 1      - Item 1
- Item 2      - Item 2
- Item 3      - Item 3
```

You can easily convert the text in between those two formats just by using
visual block mode to do something similar to paste(1) (see the
[appendix](#appendix)).

Here's a video demonstration.

<video controls="" autoplay="" name="media">
    <source src="{{< get-resource-link "demo.webm">}}" alt="demo video" type="video/webm">
</video>


## Creating columns

Let's start with the vertical form, and put your cursor on the position marked
by the block (`▋`)

```text
List title 1
- Item 1
- Item 2
- Item 3

List title 2
- Item 1
- Item 2
▋ Item 3
```

Begin visual block selection mode with `<C-v>`. Select the first character at
each line with `3k`, then extend selection to the entire block using `$h`.

Your cursor should now be on the "2" with the entire "List title 2" and the
three list items below it selected:

```text
List title 1
- Item 1
- Item 2
- Item 3

List title ▋
- Item 1
- Item 2
- Item 3
```

Now hit `x` (or `d`) to remove the block and save it in one of the default
registers temporarily.

```text
List title 1
- Item 1
- Item 2
- Item 3

```

Now, we prepare the first list to be able to paste the second list that was just
deleted. Pad spaces at the end of each line of the first list[^1]. Spaces will be shown
as `_` throughout the example.

[^1]: Alternatively, you can skip this step by using `:set virtualedit=all`.
Thanks to Martin Bays for pointing it out.

If you don't already have Vim/Neovim setup to highlight trailing spaces, you can
do so temporarily now by running `:match Underlined '\s\+$'`.

```text
List title 1_
- Item 1_____
- Item 2_____
- Item 3_____

```

Now we can paste the block we've deleted! Place your cursor on the trailing
space after "List title 1":

```text
List title 1▋
- Item 1_____
- Item 2_____
- Item 3_____

```

And hit `p`:

```text
List title 1 List title 2
- Item 1     - Item 1
- Item 2     - Item 2
- Item 3     - Item 3
```

_Voila!_ The two lists are now merged into two columns side by side.

You can easily adjust the spacing between the columns using visual block mode.
Place your cursor on the space in-between the two list titles:

```text
List title 1▋List title 2
- Item 1     - Item 1
- Item 2     - Item 2
- Item 3     - Item 3
```

Enter visual block mode and select the entire vertical column of spaces:

```text
List title 1▋List title 2
- Item 1    ▋- Item 1
- Item 2    ▋- Item 2
- Item 3    ▋- Item 3
```

Hit `A` to append text after each selection. Add a few spaces as you see fit,
and exit visual block mode (`ESC`).

```text
List title 1    List title 2
- Item 1        - Item 1
- Item 2        - Item 2
- Item 3        - Item 3
```

## Removing columns

Let's transform the text in reverse[^2]. We'll break these two columns up and have
them show up one following another vertically like what we've started with. This
might be needed when the first or second list becomes too long and you decide to
stop having them show up side by side.

[^2]: If you actually just want to reverse the process without any editing in
    between, you should of course use a few undo commands ;-)

First, place your cursor at the beginning of the third item on the second list.

```text
List title 1    List title 2
- Item 1        - Item 1
- Item 2        - Item 2
- Item 3        ▋ Item 3
```

We'll use a similar process as before to select the second list with visual
block mode. Enter visual block mode with `<C-v>`, hit `3k`, then `$h`.

Now delete the text like before.

Next we'll have to create enough space under the first list for the second list
to be pasted. (Note the trailing spaces here are only shown for completeness.)

```text
List title 1____
- Item 1________
- Item 2________
- Item 3________
⏎
⏎
⏎
⏎
⏎
```

There should be four empty lines after a blank line following the first list.

Place your cursor on the start of the second blank line:

```text
List title 1____
- Item 1________
- Item 2________
- Item 3________
⏎
▋
⏎
⏎
⏎
```

And hit `p`.

```text
List title 1____
- Item 1________
- Item 2________
- Item 3________
⏎
List title 2
- Item 1
- Item 2
- Item 3
```

And we're back to the original format.

You can easily remove the trailing spaces on the first list by running the
substitution command on a visual selection of the first list.

Use either visual mode or visual line mode to select the first paragraph, then
use `:'<,'>s/\s\+$//`.

```text
List title 1
- Item 1
- Item 2
- Item 3

List title 2
- Item 1
- Item 2
- Item 3
```

That's it!

Visual block mode is just one of the useful tools when formatting plain text and
making ascii art. I frequently use the replace mode ("write through") with `R`
to overwrite content without breaking up columns.

You can learn more about the visual block mode in Vim in the docs:
```vim
:h visual-block
```

## Appendix

Here's an example shell session to demonstrate how you can do the same thing
described in the article using the shell built-in `paste(1)`. Again, spaces are
represented as `_`.

```text
$ cat > l1.txt
List title 1_
- Item 1_____
- Item 2_____
- Item 3_____
^D
```

```text
$ cat > l2.txt
List title 2
- Item 1
- Item 2
- Item 3
^D
```

```text
$ paste -d ' ' l1.txt l2.txt
List title 1  List title 2
- Item 1      - Item 1
- Item 2      - Item 2
- Item 3      - Item 3
```

As for converting it back, I might opt for awk(1), another scripting language,
or just use Vim's visual block mode.
