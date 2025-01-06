#!/usr/bin/env python3
# word count for writingmonth.org
# 2024 - hedy - initial implementation
#             - repurpose into 100DaysToOffload tracker

import os
from datetime import datetime, timedelta
from glob import glob

START = datetime(2024, 11, 1)
COUNT = 0

# def count(file: str):
#     global COUNT
#
#     with open(file) as f:
#         contents = f.read()
#         words = contents.split("+++\n")[2].split()
#         wordcount = len(words)
#         print(file, "\t", wordcount)
#         COUNT += wordcount

last_post = START
posts = {}
postlist = []

def use_this(date_s: str, name: str):
    global posts, postlist, last_post, COUNT

    date = datetime.strptime(date_s, "%Y-%m-%d")
    posts[date] = True
    if date >= START:
        COUNT += 1
        postlist.append(date_s + " " + name)
    if date > last_post:
        last_post = date

for file in glob("content/posts/*"):
    if not os.path.isdir(file):
        continue
    date_s = file.split("/")[2][:10]
    slug = file.split("/")[2][11:]
    use_this(date_s, slug.replace("-", " ").capitalize())

with open("extra.txt") as f:
    for line in f.read().strip().splitlines():
        date_s, name = line[:10], line[11:]
        use_this(date_s, name + " (extra)")


for i, p in enumerate(sorted(postlist)):
    print(f"{i+1:3}. {p}")
print()
print(START.strftime("%Y-%m-%d"), "..", last_post.strftime("%Y-%m-%d"))
days = (last_post - START).days
print(COUNT, "posts in", days, "days")
behind = 100 / 365 * days - COUNT
print(f"{behind:.2f} days behind")

for i in range((datetime.today() - START).days + 1):
    date = START + timedelta(days=i)
    if posts.get(date):
        print("@", end="")
    else:
        print(".", end="")

print()
deltas = [3, 4, 4]
i = 0
j = 0
while j <= days + 1:
    j += deltas[i % len(deltas)]
    i += 1
    print("#" + "." * (deltas[i % len(deltas)] - 1), end="")

print()
