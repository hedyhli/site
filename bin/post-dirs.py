#!/usr/bin/env python3
# convert content/posts/*.{gmi,md} -> content/posts/*/index.{gmi,md}
# 2024 - hedy - initial implementation with logging
# post process gemini output

import os
import shutil
import sys
from functools import wraps
from glob import glob

PREFIX = os.environ['PREFIX']
DRY_RUN = len(sys.argv) > 2 and \
    sys.argv[1].lower() in ('n', '-n', '--dry-run', 'wtf', 'f')


def log(fn):
    @wraps(fn)
    def inner(*args):
        if DRY_RUN:
            print("would", end=" ")
        print(fn.__name__.replace('_', ' '),
              ' -> '.join(p.removeprefix(PREFIX) for p in args))
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

for file in glob(PREFIX+"/????-??-??-*.md"):
    basename = file.split("/")[-1].removesuffix(".md")
    dir = f"{PREFIX}/{basename}"
    mkdir(dir)
    rename(file, f"{dir}/index.md")

for file in glob(PREFIX+"/????-??-??-*.gmi"):
    basename = file.split("/")[-1].removesuffix(".gmi")
    dir = f"{PREFIX}/{basename}"
    rename(file, f"{dir}/index.gmi")
