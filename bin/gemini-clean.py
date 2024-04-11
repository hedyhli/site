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
DRY_RUN = len(sys.argv) > 2 and \
    sys.argv[1].lower() in ('n', '-n', '--dry-run', 'wtf', 'f')


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
def mkdir(d: str):
    os.makedirs(d, exist_ok=True)


################################################################
## Begin gemini clean up

# Copied as-is files
for file in (*glob(f"{GMI_DEST}/posts/????-??-??-*.gmi"),
             *glob(f"{GMI_DEST}/????-??-??-*.gmi")):
    remove(file)

# Uglify URLs
for dir in glob(f"{GMI_DEST}/*/"):
    if dir.split("/")[-1] == "posts":
        continue

    files = glob(f"{dir}/*")
    if len(files) == 1 and files[0].split("/")[-1] == "index.gmi":
        new_file = files[0].replace("/index.gmi", ".gmi")
        rename(files[0], new_file)
        remove(dir)


################################################################
## Uglify posts URLs and move post assets to a dedicated folder.

rsrc_dir = f"{GMI_DEST}/posts/assets/"
rsrc_fmt = rsrc_dir + "{slug}_{file}"

# Initialize empty resource dir
FORCE_remove_dir(rsrc_dir)
mkdir(rsrc_dir)

for path in glob(f"{GMI_DEST}/posts/*"):
    if not os.path.isdir(path):
        continue
    if path == rsrc_dir.rstrip('/'):
        continue

    for file in glob(f"{path}/*"):
        basename = file.split("/")[-1]
        if basename == "index.gmi":
            # Uglify posts URLs
            slug = file.split("/")[-2]
            rename(file, f"{path}.gmi")
            continue
        # Treat any non-index.gmi file in a post dir as resource for this post.
        # Move to dedicated resource directory.
        rename(file, rsrc_fmt.format(slug=slug, file=basename))

    remove(path)
