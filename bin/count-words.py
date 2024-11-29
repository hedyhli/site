#!/usr/bin/env python3
# word count for writingmonth.org
# 2024 - hedy - initial implementation

import os
from glob import glob

START = "2024-11-01"
COUNT = 0

def use(file: str):
    global COUNT

    with open(file) as f:
        contents = f.read()
        words = contents.split("+++\n")[2].split()
        wordcount = len(words)
        print(file, "\t", wordcount)
        COUNT += wordcount

for file in glob("content/posts/*"):
    if not os.path.isdir(file):
        continue
    date = file.split("/")[2][:10]
    if START <= date:
        use(f"{file}/index.md")

use("content/blogroll.md")
use("content/meta.md")
print(COUNT)
