+++
title = "Separating dark mode and night shift on a Mac"
description = "How I finally figured out a workaround to scheduling dark mode and night shift separately on a Mac."
date = "2025-01-21T13:02:05Z"

draft = false
outputs = ['html', 'gemtext']

slug = "separating-dark-mode-and-night-shift-on-a-mac"
tags = []

highlight = false
# font = "mono"

# [[syndications]]
# mastodon =
# bluesky =
+++


On iOS, it's possible to use a custom schedule to turn on the night shift (slightly tinted yellow-orange) mode separately from a custom schedule for dark mode. For some reason, this isn't possible on a Mac. Without resorting to 3rd-party apps, you can only either:
1. Turn off night shift, then use automatic dark mode based on sunrise/sunset, or
2. Schedule night shift, and have dark mode follow its schedule.

Unfortunately, I turn on night shift all the time (a warmer screen environment, or so I tell myself -- it's mostly placebo) but prefer to only turn on dark mode after sunset, and so option 2 is out.

Here's how I used to achieve this: for night shift, I would apply a custom schedule (such as 6:00 to 5:59) that will make sure it's always turned on. It was then possible to manually toggle dark mode via the menu bar (by enabling the display settings to be shown, alternatively, use the control center) when using my Mac at night.

However, I recently got tired of having to do this manually. While looking through configuration options for the control center, I found the Color Filters accessibility feature and found a workaround.

First, I turn off night shift and set dark mode to be "automatic". Hopefully -- according to the docs -- this will have it follow the local sunrise and sunset times (if it doesn't work, I'll find out soon enough).

Now for the night shift. I use the Color Tint option for the Color Filters accessibility feature (under "Display"). Then I set the tint to `#FF8900` and adjust the intensity as needed.

*Voila*, an ad-hoc night shift that's likely not suitable as a scientifically sound replacement, but certainly good enough for achieve the placebo effect.
