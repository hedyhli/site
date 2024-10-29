#!/usr/bin/env python3
# gemini-clean
# 2024 - hedy - initial implementation with logging
# post process gemini output

import os
import shutil
import sys
from functools import wraps
from glob import glob

GMI_DEST = os.environ["GEMINI_DEST"]
PUBLIC = os.environ["PUBLIC"]
DRY_RUN = len(sys.argv) > 2 and \
    sys.argv[1].lower() in ('n', '-n', '--dry-run', 'wtf', 'f')

if DRY_RUN:
    print("RUNNING IN DRY-RUN MODE")

def log(fn):
    @wraps(fn)
    def inner(*args):
        if DRY_RUN:
            print("would", end=" ")
        print(fn.__name__.replace('_', ' '),
              ' -> '.join(p.removeprefix(GMI_DEST) for p in args))
        if not DRY_RUN:
            fn(*args)
    return inner

@log
def remove(p: str):
    if os.path.isdir(p):
        os.rmdir(p)
    else:
        os.remove(p)

@log
def FORCE_remove_dir(p: str):
    shutil.rmtree(p, ignore_errors=True)

@log
def rename(f: str, t: str):
    os.rename(f, t)

@log
def copy(f: str, t: str):
    with open(f) as src:
        with open(t, 'w+') as dest:
            dest.write(src.read())

@log
def mkdir(d: str):
    os.makedirs(d, exist_ok=True)


################################################################
## Uglify posts URLs and move post assets to a dedicated folder.

rsrc_dir = f"{GMI_DEST}/posts/assets/"
rsrc_fmt = rsrc_dir + "{slug}_{file}"

# Initialize empty resource dir
FORCE_remove_dir(rsrc_dir)
mkdir(rsrc_dir)

for path in glob(f"{PUBLIC}/posts/*"):
    if not os.path.isdir(path):
        continue

    for file in glob(f"{path}/*"):
        basename = file.split("/")[-1]
        slug = path.rstrip("/").split("/")[-1]
        if basename.startswith("index"):
            continue
        # Treat any non-index.* file in a post dir as resource for this post.
        # Move to dedicated resource directory.
        rename(file, rsrc_fmt.format(slug=slug, file=basename))

################################################################
## Misc

copy(f"{GMI_DEST}/posts/gemini.gmi", f"{GMI_DEST}/posts.gmi")
rename(f"{GMI_DEST}/posts/gemini.gmi", f"{GMI_DEST}/posts/index.gmi")
rename(f"{GMI_DEST}/posts/index.xml", f"{GMI_DEST}/feed.xml")
